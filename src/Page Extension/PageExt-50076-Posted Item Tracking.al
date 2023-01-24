pageextension 50076 "Posted Item Tracking" extends "Posted Item Tracking Lines"
{
    layout
    {
        addafter("Expiration Date")
        {
            field("Back Pack/Display"; Rec."Back Pack/Display")
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