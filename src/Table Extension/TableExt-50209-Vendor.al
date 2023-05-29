tableextension 50209 Vendor_ext1 extends Vendor
{
    fields
    {
        field(50201; "Vendor Credit Budget.(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50202; "Old Account No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}