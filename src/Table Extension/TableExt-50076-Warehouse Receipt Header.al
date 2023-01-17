tableextension 50076 "WareHouse Rec. Header" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50071; "Vendor Invoice No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(50072; "Vendor Invoice Date"; date)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}