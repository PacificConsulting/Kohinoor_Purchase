pageextension 50220 GLEntriesExt extends "General Ledger Entries"
{
    layout
    {
        addafter("External Document No.")
        {
            field(SystemCreatedAt; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Caption = 'System Created At';
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