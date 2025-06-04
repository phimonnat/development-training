page 70129 "Ex Leave Approval Card"
{
    PageType = Card;
    SourceTable = "LeaveRequests";
    Caption = 'Ex Leave Approval Card';
    UsageCategory = Documents;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
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
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
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
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;

                trigger OnAction()
                var
                    PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
                begin
                    PermissionMgt.CheckLeaveRequestApprovalPermission(Rec);
                    if Rec."Status" <> Rec."Status"::Submitted then
                        Error('Can only approve a submitted request. Current status: %1', Rec."Status");
                    if Rec."Status" = Rec."Status"::Approved then
                        Error('Leave Request %1 is already approved.', Rec."Leave Request ID");

                    Rec."Status" := Rec."Status"::Approved;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Leave Request %1 has been approved.', Rec."Leave Request ID");
                    CurrPage.Close();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;

                trigger OnAction()
                var
                    PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
                begin
                    PermissionMgt.CheckLeaveRequestApprovalPermission(Rec);
                    if Rec."Status" <> Rec."Status"::Submitted then
                        Error('Can only reject a submitted request. Current status: %1', Rec."Status");
                    if Rec."Status" = Rec."Status"::Rejected then
                        Error('Leave Request %1 is already rejected.', Rec."Leave Request ID");

                    Rec."Status" := Rec."Status"::Rejected;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Leave Request %1 has been rejected.', Rec."Leave Request ID");
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
    begin
        PermissionMgt.CheckLeaveRequestApprovalPermission(Rec);
        if Rec."Status" <> Rec."Status"::Submitted then
            Message('This leave request has already been processed. Current status: %1', Rec."Status");
    end;
}