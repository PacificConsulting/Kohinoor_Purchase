codeunit 50202 Events
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", 'OnPostSourceDocumentOnBeforePurchPostRun', '', false, false)]
    local procedure OnPostSourceDocumentOnBeforePurchPostRun(WarehouseActivityHeader: Record "Warehouse Activity Header"; var PurchaseHeader: Record "Purchase Header");
    begin
        PurchaseHeader."LR No." := WarehouseActivityHeader."LR No.";
        PurchaseHeader."LR Date" := WarehouseActivityHeader."LR Date";
        PurchaseHeader."Vehicle No." := WarehouseActivityHeader."Vehicle No.";
        PurchaseHeader."Vendor Invoice No." := WarehouseActivityHeader."External Document No.2";
        PurchaseHeader.Modify();
    end;

    //<<<<<<<START********************************CU-90*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostItemJnlLineCopyProdOrder', '', false, false)]
    local procedure OnAfterPostItemJnlLineCopyProdOrder(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line"; PurchRcptHeader: Record "Purch. Rcpt. Header"; QtyToBeReceived: Decimal; CommitIsSupressed: Boolean; QtyToBeInvoiced: Decimal)
    begin
        ItemJnlLine."Vendor Model No." := PurchLine."Vendor Model No.";
    end;
    //<<<<<<<END********************************CU-90*****************************************

    //<<<<<<<START********************************CU-90*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertReceiptHeader', '', false, false)]
    local procedure OnAfterInsertReceiptHeader(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; CommitIsSuppressed: Boolean)
    var
        RecLoc: Record 14;
        Rlocbool: Boolean;
    begin
        //PurchRcptHeader."Vendor Invoice No." := PurchHeader."Vendor Invoice No.";

        PurchRcptHeader."Vendor Invoice No." := TempWhseRcptHeader."Vendor Invoice No.";
        PurchRcptHeader."LR No." := TempWhseRcptHeader."LR No.";
        PurchRcptHeader."LR Date" := TempWhseRcptHeader."LR Date";
        PurchRcptHeader.Remarks := TempWhseRcptHeader.Remarks;
        PurchRcptHeader."Vehicle No." := TempWhseRcptHeader."Vehicle No.";
        PurchRcptHeader.Modify();

        IF RecLoc.Get(PurchHeader."Location Code") then begin
            Rlocbool := RecLoc.RequireReceive(PurchHeader."Location Code");
            IF Rlocbool = false then begin
                PurchRcptHeader."Vendor Invoice No." := PurchHeader."Vendor Invoice No.";
                PurchRcptHeader."LR No." := PurchHeader."LR No.";
                PurchRcptHeader."LR Date" := PurchHeader."LR Date";
                PurchRcptHeader.Remarks := PurchHeader.Remarks;
                PurchRcptHeader."Vehicle No." := PurchHeader."Vehicle No.";
                PurchRcptHeader.Modify();
            end;
        end;

    end;
    //<<<<<<<END********************************CU-90*****************************************

    //<<<<<START********************************CU-6620*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopyPostedReceipt', '', false, false)]
    local procedure OnAfterCopyPostedReceipt(var ToPurchaseHeader: Record "Purchase Header"; OldPurchaseHeader: Record "Purchase Header"; FromPurchRcptHeader: Record "Purch. Rcpt. Header")
    begin
        ToPurchaseHeader."Vendor Invoice No." := FromPurchRcptHeader."Vendor Invoice No.";
        ToPurchaseHeader."LR No." := FromPurchRcptHeader."LR No.";
        ToPurchaseHeader."LR Date" := FromPurchRcptHeader."LR Date";
    end;
    //<<<<<END********************************CU-6620*****************************************

    //<<<<<START********************************CU-6500*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Management", 'OnAfterCreateSNInformation', '', false, false)]
    local procedure OnAfterCreateSNInformation(var SerialNoInfo: Record "Serial No. Information"; TrackingSpecification: Record "Tracking Specification")
    var
        Res: Record "Reservation Entry";
        PH: Record "Purchase Header";
    begin
        SerialNoInfo."Back Pack Dispaly" := TrackingSpecification."Back Pack Dispaly";
        PH.Reset();
        PH.SetRange("No.", TrackingSpecification."Source ID");
        IF PH.FindFirst() then begin
            SerialNoInfo."Inward Date" := PH."Posting Date";
        end;
        SerialNoInfo.Modify();
    end;
    //<<<<<END********************************CU-6500*****************************************

    //<<<<<START********************************PAGE-6510*****************************************
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnAfterCreateReservEntry', '', false, false)]
    local procedure OnRegisterChangeOnAfterCreateReservEntry(var ReservEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification"; OldTrackingSpecification: Record "Tracking Specification"; CurrentRunMode: Enum "Item Tracking Run Mode"; CurrentSourceType: Integer; TempReservEntry: Record "Reservation Entry");
    begin
        ReservEntry."Back Pack/Display" := OldTrackingSpecification."Back Pack/Display";
        ReservEntry.Modify();
        TrackingSpecification."Back Pack Dispaly" := OldTrackingSpecification."Back Pack Dispaly"

    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification");
    var
        SerialNoInfo: Record "Serial No. Information";
    begin
        SerialNoInfo.Reset();
        SerialNoInfo.SetRange("Item No.", SourceTrackingSpec."Item No.");
        SerialNoInfo.SetRange("Serial No.", SourceTrackingSpec."Serial No.");
        IF SerialNoInfo.FindFirst() then
            DestTrkgSpec."Back Pack Dispaly" := SerialNoInfo."Back Pack Dispaly";

        DestTrkgSpec."Back Pack/Display" := SourceTrackingSpec."Back Pack/Display";
        DestTrkgSpec."Back Pack Dispaly" := SourceTrackingSpec."Back Pack Dispaly";

    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure OnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean);
    begin
        IdenticalArray[2] := IdenticalArray[2] And (ReservEntry1."Back Pack/Display" = ReservEntry2."Back Pack/Display")
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry");
    begin
        ReservEntry."Back Pack/Display" := TrkgSpec."Back Pack/Display";
    end;
    //<<<<<END********************************PAGE-6510*****************************************

    //<<<<<<<START********************************CU-22*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure OnBeforeInsertSetupTempSplitItemJnlLine(var TempTrackingSpecification: Record "Tracking Specification"; var TempItemJournalLine: Record "Item Journal Line"; var PostItemJnlLine: Boolean; var ItemJournalLine2: Record "Item Journal Line"; SignFactor: Integer; FloatingFactor: Decimal);
    begin
        TempItemJournalLine."Back Pack/Display" := TempTrackingSpecification."Back Pack/Display";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer);
    var
        RecItem: Record 27;
    begin
        NewItemLedgEntry."Back Pack/Display" := ItemJournalLine."Back Pack/Display";
        //<<PCPL/NSW/07  CODE FOR OTHER REQUIRMENT TO FLOW NEW FIELD TO ILE
        NewItemLedgEntry.Reset();
        NewItemLedgEntry.SetRange("Item No.", RecItem."No.");
        IF NewItemLedgEntry.FindFirst() then
            NewItemLedgEntry."Item Status" := RecItem."Item Status";
        //>>PCPL/NSW/07  CODE FOR OTHER REQUIRMENT TO FLOW NEW FIELD TO ILE
        NewItemLedgEntry."Vendor Model No." := ItemJournalLine."Vendor Model No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitValueEntry', '', false, false)]
    local procedure OnAfterInitValueEntry(var ValueEntry: Record "Value Entry"; var ItemJournalLine: Record "Item Journal Line"; var ValueEntryNo: Integer; var ItemLedgEntry: Record "Item Ledger Entry");
    begin
        ValueEntry."Back Pack/Display" := ItemLedgEntry."Back Pack/Display";
    end;
    //<<<<<<<END********************************CU-22*****************************************

    //<<<<<<<START********************************CU-91*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    begin
        DefaultOption := 1;
        IF DefaultOption = 1 then begin
            IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
                PurchaseHeader.TestField("Vendor Invoice No.");
                PurchaseHeader.TestField("Document Date");
            end;
        end;

    end;
    //>>>>>>>END********************************CU-91*****************************************

    //<<<<<<<START********************************Report-5753*****************************************
    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", 'OnAfterCreateRcptHeader', '', false, false)]
    local procedure OnAfterCreateRcptHeader(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseRequest: Record "Warehouse Request"; PurchaseLine: Record "Purchase Line")
    var
        PurchaseHeader: Record 38;
    begin
        PurchaseHeader.reset;
        PurchaseHeader.SetRange("No.", PurchaseLine."Document No.");
        if PurchaseHeader.FindFirst() then begin
            WarehouseReceiptHeader."Vendor Invoice No." := PurchaseHeader."Vendor Invoice No.";
            WarehouseReceiptHeader."Vendor Invoice Date" := PurchaseHeader."Document Date";
        end;
    end;
    //<<<<<<<END********************************CU-415*****************************************
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        Vend: Record Vendor;
        PL: record "Purchase Line";
    begin
        //Code comment due post warehouse mail is sending code add on Page on relasde action
        // If PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
        //     IF PurchaseHeader.Status = PurchaseHeader.Status::Released then begin
        //         IF Vend.get(PurchaseHeader."Buy-from Vendor No.") then
        //             if Vend."E-Mail" = '' then
        //                 Message('Vendor Email is blank so system will not send the mail')
        //             else
        //                 // IF Confirm('Do you want to send the mail', true) then
        //                 PurchaseHeader.SendMail();
        //         //end;////
        //     end;
        // end;
    end;

}