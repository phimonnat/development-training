page 70128 "Ex Leave Approval List"
{
    PageType = List;
    SourceTable = "LeaveRequests";
    Caption = 'Ex Leave Approval List';
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    CardPageId = "Ex Leave Approval Card";

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
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Manager ID"; Rec."Manager ID")
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
                Scope = Repeater;

                trigger OnAction()
                begin
                    if Rec."Status" = Rec."Status"::Approved then
                        Error('Leave Request %1 is already approved.');

                    Rec."Status" := Rec."Status"::Approved;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Leave Request %1 has been approved.', Rec."Leave Request ID");
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
                Scope = Repeater;

                trigger OnAction()
                begin
                    if rec."Status" = Rec."Status"::Rejected then
                        Error('Leave Request %1 is already reject.', Rec."Leave Request ID");

                    Rec."Status" := Rec."Status"::Rejected;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Leave Request %1 has been rejected.', Rec."Leave Request ID");
                end;
            }
        }
    }
}