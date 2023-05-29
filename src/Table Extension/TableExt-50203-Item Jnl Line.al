tableextension 50203 ItemJnlLineExt extends "Item Journal Line"
{
    fields
    {
        field(50201; "Back Pack/Display"; Option)
        {
            OptionMembers = " ",Backpack,Display;
            OptionCaption = ' ,Backpack,Display';
        }
        field(50202; "Vendor Model No."; Code[20])
        {
            Caption = 'Vendor Model No.';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}