tableextension 50073 ItemJnlLineExt extends "Item Journal Line"
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