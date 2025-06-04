page 70124 "Ex Leave Requests Page"
{
    PageType = List;
    SourceTable = "LeaveRequests";
    Caption = 'Ex Leave Requests Page';
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Leave Request ID"; Rec."Leave Request ID")
                {
                    ApplicationArea = All;
                }
                field("Employee ID"; Rec."Employee ID")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
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
                }
                field("Create At"; Rec."Create At")
                {
                    ApplicationArea = All;
                }
                field("Manager ID"; Rec."Manager ID")
                {
                    ApplicationArea = All;
                }
                field("Status Changed Date"; Rec."Status Changed Date")
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
            action(NewRequest)
            {
                ApplicationArea = All;
                Caption = 'New Leave Request';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = New;

                trigger OnAction()
                var
                    LeaveRequestCard: Page "Ex Leave Requests Card";
                    LeaveRequest: Record "LeaveRequests";
                    Employee: Record "Employees";
                begin
                    LeaveRequest.Init();
                    LeaveRequest."Employee ID" := CurrentEmployeeId;
                    if Employee.Get(LeaveRequest."Employee ID") then begin
                        LeaveRequest."Manager ID" := Employee."Manager ID";
                        LeaveRequest."Employee Name" := Employee."Full Name";
                    end;
                    LeaveRequestCard.SetRecord(LeaveRequest);
                    LeaveRequestCard.RunModal();
                end;
            }
            action(EditRequest)
            {
                ApplicationArea = All;
                Caption = 'Edit Leave Request';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Edit;

                trigger OnAction()
                var
                    LeaveRequestCard: Page "Ex Leave Requests Card";
                begin
                    if Rec."Status" in [Rec."Status"::Approved, Rec."Status"::Rejected] then
                        Error('Cannot edit a request with status %1.', Rec."Status");
                    LeaveRequestCard.SetRecord(Rec);
                    LeaveRequestCard.RunModal();
                end;
            }
            action(DeleteRequest)
            {
                ApplicationArea = All;
                Caption = 'Delete Leave Request';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Delete;

                trigger OnAction()
                var
                    PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
                begin
                    PermissionMgt.CheckLeaveRequestEditPermission(Rec);
                    if Rec."Status" in [Rec."Status"::Approved, Rec."Status"::Rejected] then
                        Error('Cannot delete a request with status %1.', Rec."Status");
                    if Confirm('Are you sure you want to delete Leave Request %1?', false, Rec."Leave Request ID") then begin
                        Rec.Delete(true);
                        Message('Leave Request %1 has been deleted.', Rec."Leave Request ID");
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginPage: Page "Leave Request Login";
        PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
    begin
        if LoginPage.RunModal() <> Action::OK then
            Error('Login required to access this page.');

        CurrentEmployeeId := LoginPage.GetEmployeeId();
        PermissionMgt.SetCurrentEmployeeId(CurrentEmployeeId);

        if IsManager(CurrentEmployeeId) then
            Rec.SetRange("Manager ID", CurrentEmployeeId)
        else
            Rec.SetRange("Employee ID", CurrentEmployeeId);
        CurrPage.Update(false);
    end;

    local procedure IsManager(EmployeeId: Integer): Boolean
    var
        Employee: Record "Employees";
    begin
        if Employee.Get(EmployeeId) then
            exit(Employee."Is Manager" = Employee."Is Manager"::Yes);
        exit(false);
    end;

    var
        CurrentEmployeeId: Integer;
}