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
            RequestFilterFields = "Manager ID";

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
            column(PrintDate; PrintDate) { }

            trigger OnPreDataItem()
            var
                StartDate: Date;
                EndDate: Date;
                MonthNum: Integer;
            begin
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
                    SetRange("Status Changed Date", CreateDateTime(StartDate, 0T), CreateDateTime(EndDate, 235959T));
                end;
                CalcSummary();
            end;

            trigger OnAfterGetRecord()
            begin
                if "Status Changed Date" <> 0DT then
                    StatusChangedMonth := Format(Date2DMY(DT2Date("Status Changed Date"), 2)) + ' ' + Format(Date2DMY(DT2Date("Status Changed Date"), 3));
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
        PrintDate := Format(CurrentDateTime, 0, '<Day,2>/<Month,2>/<Year4> <Hours24>:<Minutes,2>');

        if LeaveApprovalContext.GetCurrentEmployeeId() = 0 then
            Error('Please login from the Leave Approval List page first.');
    end;

    trigger OnPostReport()
    var
        LeaveApprovalContext: Codeunit "Leave Approval Context";
    begin
        LeaveApprovalContext.ClearContext();
    end;

    local procedure CalcSummary()
    var
        LeaveRequestsRec: Record "LeaveRequests";
    begin
        ApprovedCount := 0;
        RejectedCount := 0;
        LeaveRequestsRec.CopyFilters(LeaveRequests); // ใช้ filter ทั้งหมดจาก Business Central
        if LeaveRequestsRec.FindSet() then begin
            repeat
                if LeaveRequestsRec.Status = LeaveRequestsRec.Status::Approved then
                    ApprovedCount += 1
                else if LeaveRequestsRec.Status = LeaveRequestsRec.Status::Rejected then
                    RejectedCount += 1;
            until LeaveRequestsRec.Next() = 0;
        end;
    end;

    var
        SelectedMonth: Option " ","January","February","March","April","May","June","July","August","September","October","November","December";
        SelectedYear: Integer;
        StatusChangedMonth: Text;
        ReportTitle: Text;
        CompanyInfo: Record "Company Information";
        ApprovedCount: Integer;
        RejectedCount: Integer;
        PrintDate: Text;
}