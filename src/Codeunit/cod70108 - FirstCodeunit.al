codeunit 70108 "First Codeunit"
{
    trigger OnRun()
    begin

    end;

    procedure NormalProcedure()
    begin
        Message('This is a normal procedure');
    end;

    local procedure InternalLogic()
    begin
        Message('This is a local procedure');
    end;

    [EventSubscriber(ObjectType::Table, 70100, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyFirstHeader(var Rec: Record "First Header"; var xRec: Record "First Header"; RunTrigger: Boolean)
    begin
        Message('First Header is about to be modified!');
    end;

    [EventSubscriber(ObjectType::Table, 70100, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeInsertFirstHeader(var Rec: Record "First Header"; RunTrigger: Boolean)
    begin
        Message('New First Header is about to be inserted!');
    end;

    [EventSubscriber(ObjectType::Table, 70100, 'OnBeforeModifyEvent', '', false, false)]
    local procedure OnBeforeModifyFirstHeaderBlock(var Rec: Record "First Header"; var xRec: Record "First Header"; RunTrigger: Boolean)
    begin
        if Rec."Customer No." = '10000' then
            Error('Blocked customers cannot be modified!');
    end;

    [EventSubscriber(ObjectType::Page, 70106, 'OnOpenPageEvent', '', false, false)]
    local procedure OnOpenPageFirstHeaderCard()
    begin
        Message('First Header Card is opening!');
    end;
}

