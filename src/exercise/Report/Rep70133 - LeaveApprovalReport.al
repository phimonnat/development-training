report 70133 "Leave Approval Report"
{
    Caption = 'Leave Approval Report';
    DefaultLayout = RDLC;
    RDLCLayout = './src/exercise/ReportLayout/Rpt70133 - LeaveApprovalReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(LeaveRequests; "LeaveRequests")
        {
            RequestFilterFields = Status;

            column(LeaveRequestID; "Leave Request ID") { }
            column(EmployeeID; "Employee ID") { }
            column(EmployeeName; "Employee Name") { }
            column(LeaveType; "Leave Type") { }
            column(StartDate; "Start Date") { }
            column(EndDate; "End Date") { }
            column(Status; Status) { }
            column(CreateAt; "Create At") { }
            column(ManagerID; "Manager ID") { }
            column(StatusChangedDate; "Status Changed Date") { }
            column(StatusChangedMonth; StatusChangedMonth) { }
            column(ReportTitle; ReportTitle) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(ApprovedCount; ApprovedCount) { }
            column(RejectedCount; RejectedCount) { }
            column(SubmittedCount; SubmittedCount) { }
            column(PrintDate; PrintDate) { }
            column(ManagerName; ManagerName) { }

            trigger OnPreDataItem()
            var
                StartDate: Date;
                EndDate: Date;
                MonthNum: Integer;
                StatusFilter: Text;
                HasApproved: Boolean;
                HasRejected: Boolean;
                HasSubmitted: Boolean;
            begin
                if ManagerID <> 0 then
                    SetRange("Manager ID", ManagerID);

                StatusFilter := GetFilter(Status);
                if StatusFilter = '' then
                    SetFilter(Status, '%1|%2|%3', Status::Approved, Status::Rejected, Status::Submitted)
                else begin
                    SetFilter(Status, StatusFilter);
                    HasSubmitted := StatusFilter.Contains(Format(Status::Submitted));
                    HasApproved := StatusFilter.Contains(Format(Status::Approved));
                    HasRejected := StatusFilter.Contains(Format(Status::Rejected));
                end;

                if (SelectedMonth <> SelectedMonth::" ") and (SelectedYear <> 0) then begin
                    case SelectedMonth of
                        SelectedMonth::January:
                            MonthNum := 1;
                        SelectedMonth::February:
                            MonthNum := 2;
                        SelectedMonth::March:
                            MonthNum := 3;
                        SelectedMonth::April:
                            MonthNum := 4;
                        SelectedMonth::May:
                            MonthNum := 5;
                        SelectedMonth::June:
                            MonthNum := 6;
                        SelectedMonth::July:
                            MonthNum := 7;
                        SelectedMonth::August:
                            MonthNum := 8;
                        SelectedMonth::September:
                            MonthNum := 9;
                        SelectedMonth::October:
                            MonthNum := 10;
                        SelectedMonth::November:
                            MonthNum := 11;
                        SelectedMonth::December:
                            MonthNum := 12;
                    end;

                    StartDate := DMY2Date(1, MonthNum, SelectedYear);
                    EndDate := CalcDate('CM', StartDate);

                    if StatusFilter = '' then
                        SetRange("Status Changed Date")
                    else if not HasSubmitted then
                        SetRange("Status Changed Date", CreateDateTime(StartDate, 0T), CreateDateTime(EndDate, 235959T));
                end else
                    SetRange("Status Changed Date");

                CalcSummary();
            end;

            trigger OnAfterGetRecord()
            var
                EmployeeRec: Record Employees;
            begin
                if "Status Changed Date" <> 0DT then
                    StatusChangedMonth := Format(Date2DMY(DT2Date("Status Changed Date"), 2)) + ' ' + Format(Date2DMY(DT2Date("Status Changed Date"), 3));

                if "Manager ID" <> 0 then begin
                    if EmployeeRec.Get("Manager ID") then
                        ManagerName := EmployeeRec."First Name"
                    else
                        ManagerName := '';
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(SelectedMonth; SelectedMonth)
                    {
                        ApplicationArea = All;
                        Caption = 'Select Month';
                        OptionCaption = ',January,February,March,April,May,June,July,August,September,October,November,December';
                    }
                    field(SelectedYear; SelectedYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Select Year';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            SelectedMonth := SelectedMonth::June;
            SelectedYear := 2025;

            CurrReport.SetTableView(LeaveRequests);
            if LeaveRequests.GetFilter(Status) = '' then
                LeaveRequests.SetFilter(Status, '%1|%2|%3', LeaveRequests.Status::Approved, LeaveRequests.Status::Rejected, LeaveRequests.Status::Submitted);
        end;
    }

    trigger OnPreReport()
    var
        LeaveApprovalContext: Codeunit "Leave Approval Context";
    begin
        CompanyInfo.Get();
        ReportTitle := 'Leave Approval Report';
        if (SelectedMonth <> SelectedMonth::" ") and (SelectedYear <> 0) then
            ReportTitle := ReportTitle + ' - ' + Format(SelectedMonth) + ' ' + Format(SelectedYear);
        PrintDate := Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4>');
    end;

    local procedure CalcSummary()
    var
        LeaveRequestsRec: Record "LeaveRequests";
    begin
        ApprovedCount := 0;
        RejectedCount := 0;
        SubmittedCount := 0;

        LeaveRequestsRec.CopyFilters(LeaveRequests);

        if LeaveRequestsRec.FindSet() then
            repeat
                case LeaveRequestsRec.Status of
                    LeaveRequestsRec.Status::Approved:
                        ApprovedCount += 1;
                    LeaveRequestsRec.Status::Rejected:
                        RejectedCount += 1;
                end;
            until LeaveRequestsRec.Next() = 0;

        LeaveRequestsRec.Reset();
        LeaveRequestsRec.SetRange(Status, LeaveRequestsRec.Status::Submitted);
        if LeaveRequests.GetRangeMin("Manager ID") <> 0 then
            LeaveRequestsRec.SetRange("Manager ID", LeaveRequests.GetRangeMin("Manager ID"));
        LeaveRequestsRec.SetRange("Status Changed Date");
        if LeaveRequestsRec.FindSet() then
            repeat
                SubmittedCount += 1;
            until LeaveRequestsRec.Next() = 0;
    end;

    // Parameters
    procedure SetManagerID(ID: Integer)
    begin
        ManagerID := ID;
    end;

    var
        SelectedMonth: Option " ","January","February","March","April","May","June","July","August","September","October","November","December";
        SelectedYear: Integer;
        StatusChangedMonth: Text;
        ReportTitle: Text;
        CompanyInfo: Record "Company Information";
        ApprovedCount: Integer;
        RejectedCount: Integer;
        SubmittedCount: Integer;
        PrintDate: Text;
        ManagerName: Text;
        ManagerID: Integer;
}