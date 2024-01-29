pageextension 50221 "Vendor ListExt1" extends "Vendor List"
{
    layout
    {
        addafter(Contact)
        {

            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field("GST Registration No."; Rec."GST Registration No.")
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