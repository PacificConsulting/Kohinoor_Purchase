pageextension 50072 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        addafter("Expiration Date")
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