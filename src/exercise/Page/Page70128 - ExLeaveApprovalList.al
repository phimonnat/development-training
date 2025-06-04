page 70128 "Ex Leave Approval List"
{
    PageType = List;
    SourceTable = "LeaveRequests";
    Caption = 'Ex Leave Approval List';
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = false;
    CardPageId = "Ex Leave Approval Card";

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
                field("Manager ID"; Rec."Manager ID")
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
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Approve;
                Scope = Repeater;

                trigger OnAction()
                var
                    PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
                begin
                    PermissionMgt.CheckLeaveRequestApprovalPermission(Rec);
                    if Rec."Status" = Rec."Status"::Approved then
                        Error('Leave Request %1 is already approved.', Rec."Leave Request ID");
                    if Rec."Status" <> Rec."Status"::Submitted then
                        Error('Can only approve a submitted request. Current status: %1', Rec."Status");

                    Rec."Status" := Rec."Status"::Approved;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Leave Request %1 has been approved.', Rec."Leave Request ID");
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reject;
                Scope = Repeater;

                trigger OnAction()
                var
                    PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
                begin
                    PermissionMgt.CheckLeaveRequestApprovalPermission(Rec);
                    if Rec."Status" = Rec."Status"::Rejected then
                        Error('Leave Request %1 is already rejected.', Rec."Leave Request ID");
                    if Rec."Status" <> Rec."Status"::Submitted then
                        Error('Can only reject a submitted request. Current status: %1', Rec."Status");

                    Rec."Status" := Rec."Status"::Rejected;
                    Rec."Status Changed Date" := CurrentDateTime;
                    Rec.Modify(true);
                    Message('Leave Request %1 has been rejected.', Rec."Leave Request ID");
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginPage: Page "Leave Request Login";
        PermissionMgt: Codeunit "LeaveRequestPermissionMgt";
    begin
        LoginPage.SetContext(true); // ตั้งค่าให้ใช้ Caption สำหรับฝั่งอนุมัติ
        if LoginPage.RunModal() <> Action::OK then
            Error('Login required to access this page.');

        CurrentEmployeeId := LoginPage.GetEmployeeId();
        PermissionMgt.SetCurrentEmployeeId(CurrentEmployeeId);

        Rec.SetRange("Status", Rec."Status"::Submitted);
        Rec.SetRange("Manager ID", CurrentEmployeeId);
        if Rec.IsEmpty then
            Message('No leave requests awaiting approval for Manager ID %1.', CurrentEmployeeId);
    end;

    var
        CurrentEmployeeId: Integer;
}