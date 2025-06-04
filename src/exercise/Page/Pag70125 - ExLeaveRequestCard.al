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
                        if Employee.Get(Rec."Employee ID") then begin
                            Rec."Manager ID" := Employee."Manager ID";
                            Rec."Employee Name" := Employee."Full Name";
                        end;
                        CheckAndUpdateStatus();
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

                    trigger OnValidate()
                    begin
                        CheckAndUpdateStatus();
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CheckAndUpdateStatus();
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CheckAndUpdateStatus();
                    end;
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
                begin
                    if Rec."Status" <> Rec."Status"::Submitted then
                        Error('Please complete all required fields before saving.');
                    if Rec."Create At" = 0DT then
                        Rec."Create At" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Leave Request %1 has been saved.', Rec."Leave Request ID");
                    CurrPage.Close();
                end;
            }
            action(Cancel)
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to cancel? Changes will be lost.') then begin
                        Rec.Init();
                        CurrPage.Close();
                        Message('Request cancelled.');
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec."Leave Request ID" = 0 then
            Rec."Status" := Rec."Status"::Draft;
        CurrPage.Update();
    end;

    local procedure CheckAndUpdateStatus()
    var
        Employee: Record "Employees";
    begin
        if (Rec."Employee ID" <> 0) and
           Employee.Get(Rec."Employee ID") and
           (Rec."Manager ID" <> 0) and
           Employee.Get(Rec."Manager ID") and
           (Rec."Start Date" <> 0D) and
           (Rec."End Date" <> 0D) and
           (Rec."Start Date" <= Rec."End Date") and
           (Rec."Leave Type" <> Rec."Leave Type"::None) then begin
            if Rec."Status" <> Rec."Status"::Submitted then begin
                Rec."Status" := Rec."Status"::Submitted;
                if Rec."Create At" = 0DT then
                    Rec."Create At" := CurrentDateTime;
                Rec.Modify(true);
                CurrPage.Update();
            end;
        end
        else if Rec."Status" = Rec."Status"::Submitted then begin
            Rec."Status" := Rec."Status"::Draft;
            Rec.Modify(true);
            CurrPage.Update();
        end;
    end;
}