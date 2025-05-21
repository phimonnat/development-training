page 70112 "Customer Query Page"
{
    PageType = List;
    SourceTable = "Temp Customer Query";
    SourceTableTemporary = true;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Posting_Date; Rec.Posting_Date)
                {
                    ApplicationArea = All;
                }
                field(Document_No; Rec.Document_No)
                {
                    ApplicationArea = All;
                }
                field(Remaining_Amount; Rec.Remaining_Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        CustomerQueryHandler: Codeunit "Customer Query Handler";
    begin
        CustomerQueryHandler.GetCustomerQueryData(Rec);
    end;
}