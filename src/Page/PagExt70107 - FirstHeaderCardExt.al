pageextension 70107 "First Header Card Extension" extends "First Header Card"
{
    layout
    {
        addafter("Document No.")
        {
            field("Description"; Rec."Description")
            {
                ApplicationArea = All;
                Editable = true;
                Visible = true;
            }
        }

        modify("Document No.")
        {
            Caption = 'Document Number';
            Editable = false;
        }
    }

    actions
    {
        addlast(Navigation)
        {
            action(MyAction)
            {
                ApplicationArea = All;
                Caption = 'My Action';
                Image = Action;

                trigger OnAction()
                begin
                    Message('This is a new action!');
                end;
            }

            action(CallNormalProcedure)
            {
                ApplicationArea = All;
                Caption = 'Call Normal Procedure';

                trigger OnAction()
                var
                    FirstCU: Codeunit "First Codeunit";
                begin
                    FirstCU.NormalProcedure();
                end;
            }

            action(RunCustomerQuery)
            {
                ApplicationArea = All;
                Caption = 'Run Customer Query';
                Image = View;

                trigger OnAction()
                var
                    CustomerQueryPage: Page "Customer Query Page";
                begin
                    CustomerQueryPage.Run();
                end;
            }
        }
    }
}