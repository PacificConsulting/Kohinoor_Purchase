tableextension 50072 ReservEntryExt extends "Reservation Entry"
{
    fields
    {
        field(50071; "Back Pack/Display"; Option)
        {
            OptionMembers = " ",Backpack,Display;
            OptionCaption = ' ,Backpack,Display';
        }
    }

    var
        myInt: Integer;
}