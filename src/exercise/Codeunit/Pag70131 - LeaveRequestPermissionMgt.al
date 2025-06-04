codeunit 70131 "LeaveRequestPermissionMgt"
{
    var
        CurrentEmployeeId: Integer;

    procedure SetCurrentEmployeeId(EmployeeId: Integer)
    begin
        CurrentEmployeeId := EmployeeId;
    end;

    procedure GetCurrentEmployeeId(): Integer
    begin
        exit(CurrentEmployeeId);
    end;

    procedure CheckLeaveRequestEditPermission(var LeaveRequest: Record "LeaveRequests")
    var
        Employee: Record "Employees";
    begin
        if LeaveRequest."Leave Request ID" <> 0 then begin
            if not Employee.Get(LeaveRequest."Employee ID") then
                Error('Employee ID %1 not found.', LeaveRequest."Employee ID");
            /*  if (LeaveRequest."Employee ID" <> GetCurrentEmployeeId()) and
                 (LeaveRequest."Manager ID" <> GetCurrentEmployeeId()) then
                  Error('You can only edit or delete your own leave request or requests under your management.');*/
        end;
    end;

    procedure CheckLeaveRequestApprovalPermission(var LeaveRequest: Record "LeaveRequests")
    var
        Employee: Record "Employees";
    begin
        if not Employee.Get(LeaveRequest."Manager ID") then
            Error('Manager ID %1 not found.', LeaveRequest."Manager ID");
        /* if LeaveRequest."Manager ID" <> GetCurrentEmployeeId() then
             Error('You can only approve or reject requests under your management.'); */
    end;
}