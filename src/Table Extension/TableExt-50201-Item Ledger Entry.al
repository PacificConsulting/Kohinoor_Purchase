tableextension 50201 ILEExt extends "Item Ledger Entry"
{
    fields
    {
        field(50201; "Back Pack/Display"; Option)
        {
            OptionMembers = " ",Backpack,Display;
            OptionCaption = ' ,Backpack,Display';
        }
        field(50202; "Item Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}