page 70125 "Ex Leave Requests Card"
{
    PageType = Card;
    SourceTable = "LeaveRequests";
    Caption = 'Ex Leave Requests Card';
    UsageCategory = Documents;
    ApplicationArea = All;
    Editable = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Leave Request ID"; Rec."Leave Request ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                    TableRelation = Employees."Employee ID";

                    trigger OnValidate()
                    var
                        Employee: Record "Employees";
                    begin
                        if Employee.Get(Rec."Employee ID") then
                            Rec."Manager ID" := Employee."Manager ID";
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                }
                /*field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }*/
                field("Create At"; Rec."Create At")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Manager ID"; Rec."Manager ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status Changed Date"; Rec."Status Changed Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                var
                    Employee: Record "Employees";
                begin
                    if Rec."Employee ID" = 0 then
                        Error('Employee ID is required.');
                    if not Employee.Get(Rec."Employee ID") then
                        Error('Employee ID %1 does not exist in Employees table.', Rec."Employee ID");

                    if Rec."Manager ID" = 0 then
                        Error('Manager ID is required.');
                    if not Employee.Get(Rec."Manager ID") then
                        Error('Manager ID %1 does not exist in Employees table.', Rec."Manager ID");

                    if Rec."Start Date" > Rec."End Date" then
                        Error('Start Date must be before End Date.');

                    Rec."Status" := Rec."Status"::New;
                    Rec.Insert(true);
                    Message('Leave Request %1 has been saved.', Rec."Leave Request ID");
                    CurrPage.Close();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec."Create At" := CurrentDateTime;
        CurrPage.Update();
    end;
}