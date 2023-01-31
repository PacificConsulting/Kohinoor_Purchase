tableextension 50206 "WareHouse Rec. Header" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50201; "Vendor Invoice No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50202; "Vendor Invoice Date"; date)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}