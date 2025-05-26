table 70123 "LeaveRequests"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Leave Request ID"; Integer)
        {
            Caption = 'Leave Request ID';
            AutoIncrement = true;
        }
        field(2; "Employee ID"; Integer)
        {
            Caption = 'Employee ID';
            TableRelation = Employees."Employee ID";
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Employees."First Name" where("Employee ID" = field("Employee ID")));
        }
        field(4; "Leave Type"; Option)
        {
            Caption = 'Leave Type';
            OptionMembers = "Sick Leave","Vacation","Casual Leave";
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Create At"; DateTime)
        {
            Caption = 'Create At';
        }
        field(8; "Manager ID"; Integer)
        {
            Caption = 'Manager ID';
            TableRelation = Employees."Employee ID";
        }
        field(9; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = New,Pending,Approved,Rejected;
        }
        field(10; "Status Changed Date"; DateTime)
        {
            Caption = 'Status Changed Date';
        }
        /*    field(11; "Description"; Text[250])
            {
                Caption = 'Description';
            }
            field(12; "User ID"; Code[50])
            {
                Caption = 'User ID';
            } */
    }

    keys
    {
        key(PK; "Leave Request ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Leave Request ID", "Employee ID", "Employee Name", "Start Date", "End Date", "Status")
        {

        }
    }
}