tableextension 50211 "Purch Receipt Header" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50201; "Vendor Invoice No."; Code[35])
        {
            Caption = '"Vendor Invoice No."';
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
}
