page 70132 "Leave Approval History"
{
    PageType = List;
    SourceTable = "LeaveRequests";
    Caption = 'Leave Approval History';
    UsageCategory = History;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Leave Request ID"; Rec."Leave Request ID")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Create At"; Rec."Create At")
                {
                    ApplicationArea = All;
                }
                field("Manager ID"; Rec."Manager ID")
                {
                    ApplicationArea = All;
                }
                field("Status Changed Date"; Rec."Status Changed Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewLeaveApprovalReport)
            {
                Caption = 'View Leave Approval Report';
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LeaveApprovalReport: Report "Leave Approval Report";
                    LeaveRequestsRec: Record "LeaveRequests";
                begin
                    LeaveRequestsRec.CopyFilters(Rec); // คัดลอก Filter จากหน้า
                    LeaveRequestsRec.SetRange("Manager ID", CurrentEmployeeId); // กรองตาม Manager ID
                    LeaveApprovalReport.SetTableView(LeaveRequestsRec);
                    LeaveApprovalReport.RunModal();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        LeaveApprovalContext: Codeunit "Leave Approval Context";
    begin
        CurrentEmployeeId := LeaveApprovalContext.GetCurrentEmployeeId();
        if CurrentEmployeeId = 0 then
            Error('Please login from the Leave Approval List page first.');

        Rec.SetRange("Manager ID", CurrentEmployeeId);
        Rec.SetFilter("Status", '%1|%2', Rec."Status"::Approved, Rec."Status"::Rejected);
    end;

    var
        CurrentEmployeeId: Integer;
}