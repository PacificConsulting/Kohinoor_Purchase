pageextension 50201 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        addafter("Expiration Date")
        {
            field("Back Pack/Display"; Rec."Back Pack/Display")
            {
                ApplicationArea = All;
            }
            field("Vendor Model No."; Rec."Vendor Model No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Model No. field.';
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