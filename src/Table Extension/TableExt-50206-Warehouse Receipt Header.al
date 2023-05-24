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
        field(50203; "LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50204; "LR Date"; date)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}