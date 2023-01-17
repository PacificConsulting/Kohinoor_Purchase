codeunit 50071 "Events Subscribers"
{
    trigger OnRun()
    begin
        //PAGE-6510, CU-22,91
    end;
    //<<<<<START********************************PAGE-6510*****************************************
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry', '', false, false)]
    local procedure OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry(var TrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; FormRunMode: Option);
    var
        CU50151: Codeunit 50072;
    begin
        Cu50151.AddSellStatus(NewTrackingSpecification."Back Pack/Display");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification");
    begin
        DestTrkgSpec."Back Pack/Display" := SourceTrackingSpec."Back Pack/Display";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnBeforeAddItemTrackingToTempRecSet', '', false, false)]
    local procedure OnRegisterChangeOnBeforeAddItemTrackingToTempRecSet(var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; CurrentSignFactor: Integer; var TempReservEntry: Record "Reservation Entry");
    begin
        OldTrackingSpecification."Back Pack/Display" := NewTrackingSpecification."Back Pack/Display"::" ";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean);
    begin
        ReservEntry1."Back Pack/Display" := ReservEntry2."Back Pack/Display";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterItemTrackingLinesOnAfterReclass', '', false, false)]
    local procedure OnRegisterItemTrackingLinesOnAfterReclass(var TrackingSpecification: Record "Tracking Specification"; TempTrackingSpecification: Record "Tracking Specification");
    begin
        TrackingSpecification."Back Pack/Display" := TempTrackingSpecification."Back Pack/Display";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry");
    begin
        ReservEntry."Back Pack/Display" := TrkgSpec."Back Pack/Display";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeAddToGlobalRecordSet', '', false, false)]
    local procedure OnBeforeAddToGlobalRecordSet(var TrackingSpecification: Record "Tracking Specification"; EntriesExist: Boolean; CurrentSignFactor: Integer; var TempTrackingSpecification: Record "Tracking Specification");
    Var
        SellStatus: option " ",BagPack,Display;
        CU50151: Codeunit 50072;
        ItemTrackingSetup: Record "Item Tracking Setup";
    begin
        sellstatus := CU50151.ExistingSellStatus(TrackingSpecification."Item No.", TrackingSpecification."Variant Code", ItemTrackingSetup, TrackingSpecification."Serial No.", False, EntriesExist);
        if SellStatus <> SellStatus::" " then
            TrackingSpecification."Back Pack/Display" := SellStatus;
    end;

    //>>>>>>>>END********************************PAGE-6510*****************************************



    //<<<<<<<START********************************CU-22*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine', '', false, false)]
    local procedure OnSetupTempSplitItemJnlLineOnBeforeCalcPostItemJnlLine(var TempSplitItemJnlLine: Record "Item Journal Line"; TempTrackingSpecification: Record "Tracking Specification");
    begin
        TempSplitItemJnlLine."Back Pack/Display" := TempTrackingSpecification."Back Pack/Display";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer);
    begin
        NewItemLedgEntry."Back Pack/Display" := ItemJournalLine."Back Pack/Display";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInitValueEntryOnAfterAssignFields', '', false, false)]
    local procedure OnInitValueEntryOnAfterAssignFields(var ValueEntry: Record "Value Entry"; ItemLedgEntry: Record "Item Ledger Entry"; ItemJnlLine: Record "Item Journal Line");
    begin
        ValueEntry."Back Pack/Display" := ItemLedgEntry."Back Pack/Display";
    end;

    //>>>>>>END********************************CU-22*****************************************


    //<<<<<<<START********************************CU-91*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    begin
        DefaultOption := 1;
        IF DefaultOption = 1 then begin
            PurchaseHeader.TestField("Vendor Invoice No.");
            PurchaseHeader.TestField("Document Date");
        end;

    end;
    //>>>>>>>END********************************CU-91*****************************************


    var
        myInt: Integer;
}