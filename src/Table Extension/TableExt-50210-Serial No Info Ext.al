tableextension 50210 "Serial No. Info Ext" extends "Serial No. Information"
{
    fields
    {
        field(50201; "Back Pack Dispaly"; Option)
        {
            OptionMembers = Backpack,Display;
            OptionCaption = 'Backpack,Display';
        }
        field(50202; "Inward Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}
