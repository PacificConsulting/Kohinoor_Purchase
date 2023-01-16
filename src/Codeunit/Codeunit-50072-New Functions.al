codeunit 50072 "New Functions"
{
    trigger OnRun()
    begin

    end;

    procedure ExistingSellStatus(ItemNo: Code[20]; VariantCode: Code[20]; ItemTrackingSetup: Record "Item Tracking Setup"; SerialNo: Code[20]; testMultiple: Boolean; var EntriesExist: Boolean) SellStatus: option " ",BagPack,Display;
    var
        ItemTrackMgt: Codeunit 6500;
        ILE: Record "Item Ledger Entry";
        ItemTracingMgt: Codeunit "Item Tracing Mgt.";
    Begin
        //IF not ItemTrackMgt.GetLotSNDataSet(ItemNo, VariantCode, LotNo, SerialNo, ILE) then begin //PCPL/NSW/07 old Code by deepak function update in NC cloud ne code add
        IF not ItemTrackMgt.FindLastItemLedgerEntry(ItemNo, VariantCode, ItemTrackingSetup, ILE) then begin
            EntriesExist := false;
            exit;
        end;
        EntriesExist := true;
        SellStatus := ILE."Back Pack/Display";
        //IF testMultiple AND ItemTracingMgt.SpecificTracking(ItemNo, SerialNo, LotNo) then begin //PCPL/NSW/07  old Code by deepak function update in NC cloud ne code add
        IF testMultiple AND ItemTracingMgt.IsSpecificTracking(ItemNo, ItemTrackingSetup) then begin
            ILE.SetFilter("Back Pack/Display", '<>%1', ILE."Back Pack/Display");
            ILE.SetRange(Open, true);
            if not ILE.IsEmpty then
                Error('%1 Not Found!', ItemTrackingSetup."Lot No.");
        end;
    End;

    procedure AddSellStatus(SellStatus: option " ",BagPack,Display)
    var
        ReservEntry: Record "Reservation Entry";
    Begin
        ReservEntry."Back Pack/Display" := SellStatus;
    End;

    var
        myInt: Integer;
}