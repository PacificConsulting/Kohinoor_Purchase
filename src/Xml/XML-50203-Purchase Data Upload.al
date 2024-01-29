xmlport 50203 "Purchase Document Upload"
{
    Direction = Import;
    DefaultFieldsValidation = true;
    Format = VariableText;
    FormatEvaluate = Legacy; ////
    schema
    {
        textelement(root)
        {
            //MinOccurs = Zero;
            tableelement(Integer; Integer)
            {
                XmlName = 'PurchaseHeader';
                AutoSave = false;
                textelement(DocumentType)
                {
                }
                //****New
                textelement(Postingdate)
                {
                }
                textelement(vendorNo)
                {
                }
                textelement(LocationCode)
                {
                }
                textelement(Type1)
                {
                }
                textelement(itemno)
                {
                    XmlName = 'ItemNo';
                }
                textelement(quantity)
                {
                    XmlName = 'Quantity';
                }
                textelement(DirectUnitCost)
                {
                }
                textelement(GSTGroupCode)
                {
                }
                textelement(HSNCode)
                {
                }
                textelement(TDSSection)
                {
                }
                textelement(PayemntCode)
                {
                }
                textelement(VendorInvNo)
                {
                }
                textelement(VendorInvDate)
                {
                }
                textelement(GlobalDimension1)
                {
                }
                textelement(GlobalDimension2)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    PurchPay.Get();
                    EVALUATE(DocType, DocumentType);
                    PurchaseHeader.RESET;
                    PurchaseHeader.SETRANGE("Document Type", DocType);
                    PurchaseHeader.SETRANGE("No.", DocNo);
                    PurchaseHeader.SetRange("Location Code", LocationCode);
                    PurchaseHeader.SetRange("Vendor Invoice No.", VendorInvNo);
                    IF NOT PurchaseHeader.FINDFIRST THEN BEGIN
                        PurchaseHeader.INIT;
                        PurchaseHeader.VALIDATE(PurchaseHeader."Document Type", DocType);
                        IF DocType = DocType::Order then begin
                            PurchPay.TestField(PurchPay."Order Nos.");
                            DocNo := NoSeriesMgt.GetNextNo(PurchPay."Order Nos.", PurchaseHeader."Posting Date", True);
                            PurchaseHeader."No." := DocNo;
                        end else
                            if DocType = DocType::Invoice then begin
                                PurchPay.TestField(PurchPay."Invoice Nos.");
                                DocNo := NoSeriesMgt.GetNextNo(PurchPay."Invoice Nos.", PurchaseHeader."Posting Date", true);
                                PurchaseHeader."No." := DocNo;
                            end else
                                if DocType = DocType::"Credit Memo" then begin
                                    PurchPay.TestField(PurchPay."Credit Memo Nos.");
                                    DocNo := NoSeriesMgt.GetNextNo(PurchPay."Credit Memo Nos.", PurchaseHeader."Posting Date", true);
                                    PurchaseHeader."No." := DocNo;
                                end else
                                    if DocType = DocType::"Return Order" then begin
                                        PurchPay.TestField(PurchPay."Return Order Nos.");
                                        DocNo := NoSeriesMgt.GetNextNo(PurchPay."Return Order Nos.", PurchaseHeader."Posting Date", true);
                                        PurchaseHeader."No." := DocNo;
                                    end;

                        PurchaseHeader.INSERT(TRUE);
                        PurchaseHeader.VALIDATE("Buy-from Vendor No.", vendorNo);
                        EVALUATE(PostDate, Postingdate);
                        PurchaseHeader.VALIDATE(PurchaseHeader."Posting Date", PostDate);
                        PurchaseHeader.Validate("Payment Terms Code", PayemntCode);
                        PurchaseHeader.validate("Vendor Invoice No.", VendorInvNo);
                        PurchaseHeader.validate("Vendor Cr. Memo No.", VendorInvNo);
                        EVALUATE(DocDate, VendorInvDate);
                        PurchaseHeader.validate("Document Date", DocDate);
                        PurchaseHeader.VALIDATE(PurchaseHeader."Location Code", LocationCode);
                        PurchaseHeader.VALIDATE("Shortcut Dimension 1 Code", GlobalDimension1);
                        PurchaseHeader.VALIDATE("Shortcut Dimension 2 Code", GlobalDimension2);
                        PurchaseHeader.MODIFY(true);
                        COMMIT;

                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                        IF PurchaseLine.FINDLAST THEN
                            Linenumber := PurchaseLine."Line No." + 10000
                        ELSE
                            Linenumber := 10000;

                        PurchaseLine.INIT;
                        PurchaseLine.VALIDATE(PurchaseLine."Document Type", DocType);
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := Linenumber;
                        PurchaseLine.INSERT(TRUE);
                        Evaluate(ItemType, type1);
                        PurchaseLine.Validate(Type, ItemType);
                        PurchaseLine.VALIDATE(PurchaseLine."No.", ItemNo);
                        PurchaseLine.VALIDATE(PurchaseLine."Location Code", PurchaseHeader."Location Code");
                        EVALUATE(Qty, Quantity);
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity, Qty);
                        //PurchaseLine.VALIDATE("Unit of Measure", UOM);
                        EVALUATE(DirectUnitCostValue, DirectUnitCost);
                        PurchaseLine.Validate("GST Group Code", GSTGroupCode);
                        PurchaseLine.Validate("HSN/SAC Code", HSNCode);
                        PurchaseLine.Validate("GST Credit", PurchaseLine."GST Credit"::Availment);
                        PurchaseLine.Validate("TDS Section Code", TDSSection);
                        PurchaseLine.VALIDATE("Direct Unit Cost", DirectUnitCostValue);
                        PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 1 Code");
                        PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", PurchaseHeader."Shortcut Dimension 2 Code");
                        PurchaseLine.MODIFY(TRUE);

                    END ELSE BEGIN
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                        IF PurchaseLine.FINDLAST THEN
                            Linenumber := PurchaseLine."Line No." + 10000
                        ELSE
                            Linenumber := 10000;
                        PurchaseLine.INIT;
                        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := Linenumber;
                        PurchaseLine.INSERT(TRUE);
                        PurchaseLine.Validate(Type, ItemType);
                        PurchaseLine.VALIDATE(PurchaseLine."No.", ItemNo);
                        PurchaseLine.VALIDATE(PurchaseLine."Location Code", PurchaseHeader."Location Code");
                        EVALUATE(Qty, Quantity);
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity, Qty);

                        // PurchaseLine.VALIDATE("Unit of Measure", UOM);
                        EVALUATE(DirectUnitCostValue, DirectUnitCost);
                        PurchaseLine.VALIDATE("Direct Unit Cost", DirectUnitCostValue);
                        PurchaseLine.MODIFY(TRUE);
                    END;

                end;

                trigger OnAfterInitRecord()
                begin
                    I += 1;
                    IF I = 1 THEN
                        currXMLport.SKIP;
                end;

            }

        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }


    trigger OnPostXmlPort()
    begin
        MESSAGE('Data has been imported successfully, Last Document No. is %1', PurchaseHeader."No.");
    end;

    var

        Text0001: Label 'Item No. %1 is not a part of Purchase %2 No. %3';
        Text0002: Label 'Please Modify the Quantity for Item No. %1 as the Quantity being recieved is more than %2. Total Quantity being recieved is %3';
        Linenumber: Integer;
        PurchaseHeader: Record 38;
        PostDate: Date;
        DocDate: Date;
        PurchaseLine: Record 39;
        Unit: Decimal;
        Qty: Decimal;
        //NoSerMngt: Codeunit no
        Item: Record 27;
        BrandInp: Code[20];
        OrderNoSeries: Code[20];
        Location: Record 14;
        NoBOx: Decimal;
        DirectUnitCostValue: Decimal;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        firstline: Boolean;
        "GlobalDimension-1": Record 349;
        NoSeriesMgt: Codeunit 396;
        ItemType: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        DocNo: Code[20];
        PurchPay: Record "Purchases & Payables Setup";
        I: Integer;

}

