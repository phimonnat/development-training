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
        field(7; "Approval Rights"; Text[100])
        {
            Caption = 'Approval Rights';
        }
        field(8; "Manager ID"; Integer)
        {
            Caption = 'Manager ID';
            TableRelation = Employees."Employee ID";
        }
        field(9; "Is Manager"; Boolean)
        {
            Caption = 'Is Manager';
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