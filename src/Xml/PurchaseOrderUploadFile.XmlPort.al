xmlport 50072 "Purchase Order Upload 1"
{
    FieldDelimiter = '<">';
    FieldSeparator = ',';
    Format = VariableText;


    schema
    {
        textelement(root)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'PurchaseHeader';
                // SourceTableView = SORTING(Field1) //PCPL-064
                //WHERE(Field1 = CONST(1));
                SourceTableView = SORTING(Number) //new//PCPL-064
                                  WHERE(Number = CONST(1));
                textelement(DocumentType)
                {
                }
                textelement(DocNo)
                {
                }
                textelement(vendorNo)
                {
                }
                textelement(DocumentDate)
                {
                }
                textelement(Postingdate)
                {
                }
                textelement(ExternalDocumentNo)
                {
                }
                textelement(vStructure)
                {
                }
                textelement(ItemNo)
                {
                }
                textelement(Quantity)
                {
                }
                textelement(UOM)
                {
                }
                textelement(DirectUnitCost)
                {
                }
                textelement(LocationCode)
                {
                }
                textelement(DocGDim)
                {
                    MinOccurs = Zero;
                }

                trigger OnBeforeInsertRecord()
                begin
                    IF firstline THEN BEGIN
                        firstline := FALSE;
                        currXMLport.SKIP;
                    END;
                    EVALUATE(DocType, DocumentType);

                    PurchaseHeader.RESET;
                    PurchaseHeader.SETRANGE("Document Type", DocType);
                    //PurchaseHeader.SETRANGE("No.", DocNo);
                    IF NOT PurchaseHeader.FINDFIRST THEN BEGIN
                        PurchaseHeader.INIT;
                        PurchaseHeader.VALIDATE(PurchaseHeader."Document Type", DocType);
                        DocNo := NoSeriesMgt.GetNextNo('P-ORD', PurchaseHeader."Posting Date", false);
                        PurchaseHeader."No." := DocNo;
                        PurchaseHeader.INSERT(TRUE);
                        PurchaseHeader.VALIDATE("Buy-from Vendor No.", vendorNo);
                        //PurchaseHeader.VALIDATE(PurchaseHeader."Location Code",LocationCode);
                        EVALUATE(PostDate, Postingdate);
                        EVALUATE(DocDate, DocumentDate);
                        PurchaseHeader.VALIDATE("Document Date", DocDate);
                        PurchaseHeader.VALIDATE(PurchaseHeader."Posting Date", PostDate);
                        //PurchaseHeader.VALIDATE(Structure,Structure);
                        PurchaseHeader.VALIDATE(PurchaseHeader."Location Code", LocationCode);
                        PurchaseHeader.VALIDATE("Shortcut Dimension 1 Code", DocGDim);
                        PurchaseHeader.VALIDATE("Vendor Invoice No.", ExternalDocumentNo);
                        PurchaseHeader.MODIFY;
                        COMMIT;
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE(PurchaseLine."Document No.", DocNo);
                        IF PurchaseLine.FINDLAST THEN
                            Linenumber := PurchaseLine."Line No." + 10000
                        ELSE
                            Linenumber := 10000;
                        PurchaseLine.INIT;
                        PurchaseLine."Document Type" := PurchaseHeader."Document Type";
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := Linenumber;
                        PurchaseLine.INSERT(TRUE);
                        PurchaseLine.VALIDATE(PurchaseLine."Location Code", LocationCode);//
                        PurchaseLine.VALIDATE(Type, PurchaseLine.Type::Item);
                        PurchaseLine.VALIDATE(PurchaseLine."No.", ItemNo);
                        EVALUATE(Qty, Quantity);
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity, Qty);
                        PurchaseLine.VALIDATE("Unit of Measure", UOM);
                        EVALUATE(DirectUnitCostValue, DirectUnitCost);
                        PurchaseLine.VALIDATE("Direct Unit Cost", DirectUnitCostValue);
                        PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 1 Code");
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
                        PurchaseLine.VALIDATE(PurchaseLine."Location Code", LocationCode);//
                        PurchaseLine.VALIDATE(Type, PurchaseLine.Type::Item);
                        PurchaseLine.VALIDATE(PurchaseLine."No.", ItemNo);
                        EVALUATE(Qty, Quantity);
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity, Qty);
                        PurchaseLine.VALIDATE("Unit of Measure", UOM);
                        EVALUATE(DirectUnitCostValue, DirectUnitCost);
                        PurchaseLine.VALIDATE("Direct Unit Cost", DirectUnitCostValue);
                        PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", PurchaseHeader."Shortcut Dimension 1 Code");
                        PurchaseLine.MODIFY(TRUE);
                    END;
                    //PurchaseHeader.Structure := vStructure;
                    PurchaseHeader.MODIFY;
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
        MESSAGE('Data Has Been Imported Successfully');
    end;

    trigger OnPreXmlPort()
    begin
        firstline := TRUE;
    end;

    var
        Linenumber: Integer;
        PurchaseHeader: Record 38;
        PostDate: Date;
        DocDate: Date;
        PurchaseLine: Record 39;
        Unit: Decimal;
        Qty: Decimal;
        DirectUnitCostValue: Decimal;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        firstline: Boolean;
        "GlobalDimension-1": Record 349;
        NoSeriesMgt: Codeunit 396;
}

