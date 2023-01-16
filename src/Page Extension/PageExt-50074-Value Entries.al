pageextension 50074 ValueEntryExt extends "Value Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Back Pack/Display"; Rec."Back Pack/Display")
            {
                ApplicationArea = All;
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