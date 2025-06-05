codeunit 70134 "Leave Approval Context"
{
    SingleInstance = true;

    procedure SetCurrentEmployeeId(EmployeeId: Integer)
    begin
        CurrentEmployeeId := EmployeeId;
    end;

    procedure GetCurrentEmployeeId(): Integer
    begin
        exit(CurrentEmployeeId);
    end;

    procedure ClearContext()
    begin
        CurrentEmployeeId := 0;
    end;

    var
        CurrentEmployeeId: Integer;
}