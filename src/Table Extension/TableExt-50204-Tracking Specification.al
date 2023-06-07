tableextension 50204 TrackSpecExt extends "Tracking Specification"
{
    fields
    {
        field(50201; "Back Pack/Display"; Option)
        {
            OptionMembers = " ",Backpack,Display;
            OptionCaption = ' ,Backpack,Display';
        }
        field(50202; "Back Pack Dispaly"; TExt[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Posting Date" where("Serial No." = field("Serial No.")));
        }
        modify("Lot No.")
        {
            trigger OnAfterValidate()
            begin
                InitSellStatus();
            end;
        }
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            var
                SerialNoInfo: Record "Serial No. Information";
            begin
                SerialNoInfo.Reset();
                SerialNoInfo.SetRange("Item No.", Rec."Item No.");
                SerialNoInfo.SetRange("Serial No.", Rec."Serial No.");
                IF SerialNoInfo.FindFirst() then
                    Rec."Back Pack Dispaly" := SerialNoInfo."Back Pack Dispaly";
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