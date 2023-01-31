tableextension 50209 Vendor_ext1 extends Vendor
{
    fields
    {
        field(50201; "Vendor Credit Budget.(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
    }

    var
        myInt: Integer;
}