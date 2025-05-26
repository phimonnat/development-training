page 70124 "Ex Leave Requests Page"
{
    PageType = List;
    SourceTable = "LeaveRequests";
    Caption = 'Ex Leave Requests';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Ex Leave Requests Card";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                /*  field("User ID"; Rec."User ID")
                  {
                      ApplicationArea = All;
                  } */
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

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify();
                    Message('Leave Request %1 has been approved.')
                end;
            }

            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify();
                    Message('Leave Request %1 has been rejected.');
                end;
            }
        }
    }

}