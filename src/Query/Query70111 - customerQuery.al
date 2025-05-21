query 70111 "Customer Query"
{
    QueryType = Normal;

    elements
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            {

            }
            column(Name; Name)
            {

            }
            dataitem(Cust__Ledger_Entry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = Customer."No.";
                column(Posting_Date; "Posting Date")
                {

                }
                column(Document_No_; "Document No.")
                {

                }
                column(Remaining_Amount; "Remaining Amount")
                {

                }
            }
        }
    }
}