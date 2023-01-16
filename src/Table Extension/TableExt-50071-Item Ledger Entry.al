tableextension 50071 ILEExt extends "Item Ledger Entry"
{
    fields
    {
        field(50150; "Back Pack/Display"; Option)
        {
            OptionMembers = " ",Backpack,Display;
            OptionCaption = ' ,Backpack,Display';
        }
    }

    var
        myInt: Integer;
}