page 70127 "Ex Employees List"
{
    PageType = List;
    SourceTable = "Employees";
    Caption = 'Ex Employees List';
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    CardPageId = "Ex Employees Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
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
                field("Approval Rights"; Rec."Approval Rights")
                {
                    ApplicationArea = All;
                }
                field("Manager ID"; Rec."Manager ID")
                {
                    ApplicationArea = All;
                }
                field("Is Manager"; Rec."Is Manager")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}