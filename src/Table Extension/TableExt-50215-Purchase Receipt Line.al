tableextension 50215 "Purchase Receipt Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50201; "Vendor Model No."; Code[20])
        {
            Caption = 'Vendor Model No.';
            DataClassification = ToBeClassified;
        }
    }
}
