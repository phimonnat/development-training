table 70122 "Employees"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            AutoIncrement = true;
        }
        field(2; "First Name"; Text[50])
        {
            Caption = 'First Name';
        }
        field(3; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(4; "Email"; Text[100])
        {
            Caption = 'Email';
        }
        field(5; "Job Title"; Text[50])
        {
            Caption = 'Job Title';
        }
        field(6; "Department"; Text[50])
        {
            Caption = 'Department';
        }
        field(7; "Approval Rights"; Option)
        {
            OptionMembers = "None","Full";
        }
        field(8; "Manager ID"; Integer)
        {
            Caption = 'Manager ID';
            TableRelation = Employees."Employee ID" where("Is Manager" = const("Yes"));

            trigger OnValidate()
            var
                Employee: Record "Employees";
            begin
                if Rec."Manager ID" <> 0 then begin
                    if not Employee.Get(Rec."Manager ID") then
                        Error('Manager ID %1 does not exist.', Rec."Manager ID");
                    if Employee."Is Manager" <> Employee."Is Manager"::Yes then
                        Error('Selected Manager ID %1 is not a manager.', Rec."Manager ID");
                end;
            end;
        }
        field(9; "Is Manager"; Option)
        {
            OptionMembers = "No","Yes";
        }
    }

    keys
    {
        key(PK; "Employee ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employee ID", "First Name", "Last Name", "Job Title", Department)
        {
        }
    }
}