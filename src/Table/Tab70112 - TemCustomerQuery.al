table 70112 "Temp Customer Query"
{
    DataClassification = ToBeClassified;
    TableType = Temporary;

    fields
    {
        field(1; No; Code[20])
        {
            Caption = 'No';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; Posting_Date; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(4; Document_No; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; Remaining_Amount; Decimal)
        {
            Caption = 'Remaining Amount';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; No, Document_No)
        {
            Clustered = true;
        }
    }
}