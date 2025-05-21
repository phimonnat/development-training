page 70106 "First Header Card"
{
    PageType = Card;
    SourceTable = "First Header";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Message('This is OnValidate of Document No.');
                    end;
                }
            }
            group(CustomerInfo)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Message('This is OnValidate of Customer No.');
                    end;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
            }
            group(Financials)
            {
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
            }
            part("First Subpage"; "First Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("Document No.");
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
                Image = Email;
                trigger OnAction()
                begin
                    Message('Customer has been notified for Document %1.', Rec."Document No.");
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
