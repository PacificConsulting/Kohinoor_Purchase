tableextension 50071 ILEExt extends "Item Ledger Entry"
{
    fields
    {
        field(50071; "Back Pack/Display"; Option)
        {
            OptionMembers = " ",Backpack,Display;
            OptionCaption = ' ,Backpack,Display';
        }
        field(50072; "Item Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}