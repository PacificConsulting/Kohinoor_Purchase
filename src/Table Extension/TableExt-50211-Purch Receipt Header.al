tableextension 50211 "Purch Receipt Header" extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50201; "Vendor Invoice No."; Code[35])
        {
            Caption = '"Vendor Invoice No."';
            DataClassification = ToBeClassified;
        }
    }
}
