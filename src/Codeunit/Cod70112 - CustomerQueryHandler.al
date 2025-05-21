codeunit 70112 "Customer Query Handler"
{
    procedure GetCustomerQueryData(var TempCustQuery: Record "Temp Customer Query" temporary)
    var
        CustomerQuery: Query "Customer Query";
    begin
        TempCustQuery.Reset();
        TempCustQuery.DeleteAll();
        CustomerQuery.Open();
        while CustomerQuery.Read() do begin
            TempCustQuery.Init();
            TempCustQuery.No := CustomerQuery.No;
            TempCustQuery.Name := CustomerQuery.Name;
            TempCustQuery.Posting_Date := CustomerQuery.Posting_Date;
            TempCustQuery.Document_No := CustomerQuery.Document_No_;
            TempCustQuery.Remaining_Amount := CustomerQuery.Remaining_Amount;
            if not TempCustQuery.Insert() then
                TempCustQuery.Modify();
        end;
        CustomerQuery.Close();
    end;
}