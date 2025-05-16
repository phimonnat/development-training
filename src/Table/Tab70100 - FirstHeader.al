table 70100 "First Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.get("Customer No.") then
                    "Customer Name" := CustomerRec.Name
                else
                    "Customer Name" := '';
            end;

        }

        field(3; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(4; "Balance (LCY)"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)"
                where("Customer No." = field("Customer No.")));
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Dropdown; "Document No.", "Customer No.")
        {
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        Message('This is onInsert trigger !');
    end;

    trigger OnModify()
    begin
        Message('This is onModify trigger !');
    end;

    trigger OnDelete()
    begin
        Message('This is onDelete trigger !');
    end;

    trigger OnRename()
    begin
        Message('This is onRename trigger !');
    end;

}
