page 70130 "Leave Request Login"
{
    PageType = StandardDialog;
    Caption = 'Login to Leave Request System';
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Employee ID"; EmployeeId)
                {
                    ApplicationArea = All;
                    Caption = 'Employee ID';

                    trigger OnValidate()
                    var
                        Employee: Record "Employees";
                    begin
                        if not Employee.Get(EmployeeId) then
                            Error('Employee ID %1 not found.', EmployeeId);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OK)
            {
                ApplicationArea = All;
                Caption = 'OK';
                InFooterBar = true;

                trigger OnAction()
                begin
                    if EmployeeId = 0 then
                        Error('Please enter a valid Employee ID.');
                    CurrPage.Close();
                end;
            }
            action(Cancel)
            {
                ApplicationArea = All;
                Caption = 'Cancel';
                InFooterBar = true;

                trigger OnAction()
                begin
                    EmployeeId := 0;
                    CurrPage.Close();
                end;
            }
        }
    }

    procedure GetEmployeeId(): Integer
    begin
        exit(EmployeeId);
    end;

    procedure SetContext(IsApproval: Boolean)
    begin
        if IsApproval then
            CurrPage.Caption := 'Login to Leave Approval System'
        else
            CurrPage.Caption := 'Login to Leave Request System';
    end;

    var
        EmployeeId: Integer;
}