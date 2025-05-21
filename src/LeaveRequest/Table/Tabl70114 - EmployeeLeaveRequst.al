table 70114 "Employee Leave Request"
{
    DataClassification = CustomerContent; //set data type for security

    fields
    {
        field(1; "Leave ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Leave ID';
        }
        field(2; "Employee ID"; Code[20])
        {
            Caption = 'Employee ID';
            TableRelation = Employee."No.";
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField; // real time cal
            CalcFormula = lookup(Employee."First Name" where("No." = field("Employee ID"))); // fetch name from Employee
        }
        field(4; "Leave Start Date"; Date)
        {
            Caption = 'Leave Start Date';
        }
        field(5; "Leave End date"; Date)
        {
            Caption = 'Leave End Date';
        }
        field(6; "Leave Type"; Option)
        {
            Caption = 'Leave Type';
            OptionMembers = "Sick Leave","Vacation","Casual Leave"; // leave type
        }
        field(7; Status; Option)
        {
            Caption = 'Description';
            OptionMembers = New,Pending,Approved,Rejected; // status option
        }
        field(8; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(9; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
    }

    keys
    {
        // primary key setup
        key(PK; "Leave ID")
        {
            Clustered = true;  // set primary key for fast search
        }
    }
}