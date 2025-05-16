page 70101 "First Header List"
{
    PageType = List;
    SourceTable = "First Header";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Message('This is OnValidate of Document No.');
                    end;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Message('This OnValidate of Customer No.');
                    end;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }

                field("Balance (LCY)"; Rec."Balance (LCY)")
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
            action(NotifyCustomer)
            {
                ApplicationArea = All;
                Caption = 'Notify Customer';
                Image = SendEmail;

                trigger OnAction()
                begin
                    Message('Customer has been notified for Document for Document %1.', Rec."Document No.");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Message('This is OnOpenPage trigger.');
    end;


    trigger OnClosePage()
    begin
        Message('This is OnClosePage trigger.');
    end;
}

