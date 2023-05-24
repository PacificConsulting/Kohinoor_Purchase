tableextension 50212 "Posted Whse. receipt header" extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(50201; "Vendor Invoice No."; Code[35])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50202; "Vendor Invoice Date"; date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50203; "LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50204; "LR Date"; date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}