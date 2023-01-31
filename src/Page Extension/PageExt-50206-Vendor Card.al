pageextension 50206 "Vendor Card Ext1" extends "Vendor Card"
{
    layout
    {
        addafter("Balance Due (LCY)")
        {
            field("Vendor Credit Budget.(LCY)"; Rec."Vendor Credit Budget.(LCY)")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}