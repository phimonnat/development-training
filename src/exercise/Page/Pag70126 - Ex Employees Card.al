page 70126 "Ex Employees Card"
{
    PageType = Card;
    SourceTable = "Employees";
    Caption = 'Ex Employees Card';
    UsageCategory = Documents;
    ApplicationArea = All;
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Email"; Rec."Email")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Department"; Rec."Department")
                {
                    ApplicationArea = All;
                }
                field("Is Manager"; Rec."Is Manager")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Is Manager" = Rec."Is Manager"::Yes then
                            Rec."Approval Rights" := Rec."Approval Rights"::None;
                        CurrPage.Update();
                    end;
                }
                field("Manager ID"; Rec."Manager ID")
                {
                    ApplicationArea = All;
                    TableRelation = Employees."Employee ID" where("Is Manager" = const("Yes"));
                }
                field("Approval Rights"; Rec."Approval Rights")
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
            action(Save)
            {
                ApplicationArea = All;
                Caption = 'Save';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."First Name" = '' then
                        Error('First Name is required.');
                    if Rec."Last Name" = '' then
                        Error('Last Name is required.');
                    Rec.Insert(true);
                    Message('Employee %1 has been saved.', Rec."Employee ID");
                    CurrPage.Close();
                end;
            }
        }
    }
}