page 70115 "Leave Requests Page"
{
    // page setup
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Leave Request";
    CardPageId = "Leave Request Card";

    layout
    {
        // layout setup
        area(Content)
        {
            repeater(Group)
            {
                // field to display
                field("Leave ID"; Rec."Leave ID")
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
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    ApplicationArea = All;
                }
                field("Leave End date"; Rec."Leave End date")
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; Rec."Leave Type")
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
                field("User ID"; Rec."User ID")
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
                Image = Approve;
                Promoted = true; // show in ribbon
                PromotedCategory = Process; // category in ribbon

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Approved;  // set status to Approved
                    Rec.Modify(); //save change
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Rejected; // set status to Rejected
                    rec.Modify();
                end;
            }
        }
    }
}