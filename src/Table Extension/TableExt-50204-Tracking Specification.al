tableextension 50204 TrackSpecExt extends "Tracking Specification"
{
    fields
    {
        field(50201; "Back Pack/Display"; Option)
        {
            OptionMembers = " ",Backpack,Display;
            OptionCaption = ' ,Backpack,Display';
        }
        modify("Lot No.")
        {
            trigger OnAfterValidate()
            begin
                InitSellStatus();
            end;
        }
    }

    procedure InitSellStatus()
    var
        SellStaus: Option;
        CU50151: Codeunit 50201;
        EntriesExist: Boolean;
        ItemTrackingSetup: Record "Item Tracking Setup";
    Begin
        if ("Serial No." = xRec."Serial No.") AND ("Lot No." = xRec."Lot No.") then
            exit;
        "Back Pack/Display" := Rec."Back Pack/Display"::" ";
        SellStaus := CU50151.ExistingSellStatus("Item No.", "Variant Code", ItemTrackingSetup, "Serial No.", false, EntriesExist);
        if EntriesExist then
            "Back Pack/Display" := SellStaus;
    End;

    var
        myInt: Integer;
}