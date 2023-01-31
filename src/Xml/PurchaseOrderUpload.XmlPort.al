xmlport 50201 "Purchase Order Upload"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            MinOccurs = Zero;
            tableelement(Integer; Integer)
            {
                XmlName = 'PurchaseHeader';
                textelement(DocumentType)
                {
                }
                textelement(No)
                {
                }
                textelement(vendorNo)
                {
                }
                textelement(DocumentDate)
                {
                    MinOccurs = Zero;
                }
                textelement(Postingdate)
                {
                }
                textelement(ExternalDocumentNo)
                {
                }
                textelement(Structure)
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
                textelement(UOM)
                {
                }
                textelement(DirectUnitCost)
                {
                }
                textelement(LocationCode)
                {
                }
                textelement(GlobalDimension1)
                {
                }

                trigger OnAfterInitRecord()
                begin
                    IF firstline THEN BEGIN
                        firstline := FALSE;
                        currXMLport.SKIP;
                    END;
                    EVALUATE(DocType, DocumentType);
                    PurchaseHeader.RESET;
                    PurchaseHeader.SETRANGE("Document Type", DocType);
                    PurchaseHeader.SETRANGE("No.", No);
                    IF NOT PurchaseHeader.FINDFIRST THEN BEGIN
                        PurchaseHeader.INIT;
                        PurchaseHeader.VALIDATE(PurchaseHeader."Document Type", DocType);
                        No := NoSeriesMgt.GetNextNo('P-ORD', PurchaseHeader."Posting Date", false);
                        PurchaseHeader."No." := No;
                        PurchaseHeader.INSERT(TRUE);
                        PurchaseHeader.VALIDATE(PurchaseHeader."Location Code", LocationCode);
                        PurchaseHeader.VALIDATE("Buy-from Vendor No.", vendorNo);
                        EVALUATE(PostDate, Postingdate);
                        EVALUATE(DocDate, DocumentDate);
                        PurchaseHeader.VALIDATE("Document Date", DocDate);
                        PurchaseHeader.VALIDATE(PurchaseHeader."Posting Date", PostDate);
                        PurchaseHeader.VALIDATE("Shortcut Dimension 1 Code", GlobalDimension1);
                        PurchaseHeader.MODIFY;
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                        IF PurchaseLine.FINDLAST THEN
                            Linenumber := PurchaseLine."Line No." + 10000
                        ELSE
                            Linenumber := 10000;
                        PurchaseLine.INIT;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := Linenumber;
                        PurchaseLine.INSERT(TRUE);
                        PurchaseLine.VALIDATE(PurchaseLine."Location Code", PurchaseHeader."Location Code");
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
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := Linenumber;
                        PurchaseLine.INSERT(TRUE);
                        PurchaseLine.VALIDATE(PurchaseLine."Location Code", PurchaseHeader."Location Code");
                        PurchaseLine.VALIDATE(PurchaseLine."No.", ItemNo);
                        EVALUATE(Qty, Quantity);
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity, Qty);
                        PurchaseLine.VALIDATE("Unit of Measure", UOM);
                        EVALUATE(DirectUnitCostValue, DirectUnitCost);
                        PurchaseLine.VALIDATE("Direct Unit Cost", DirectUnitCostValue);
                        PurchaseLine.MODIFY(TRUE);
                    END;
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
        Text0001: Label 'Item No. %1 is not a part of Purchase %2 No. %3';
        Text0002: Label 'Please Modify the Quantity for Item No. %1 as the Quantity being recieved is more than %2. Total Quantity being recieved is %3';
        Linenumber: Integer;
        PurchaseHeader: Record 38;
        PostDate: Date;
        DocDate: Date;
        PurchaseLine: Record 39;
        Unit: Decimal;
        Qty: Decimal;
        NoSerMngt: Codeunit 396;
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

    // [Scope('Internal')]
    procedure SetInputs(Brand_: Code[20]; OrderNoSeries_: Code[20])
    begin
        BrandInp := Brand_;
        OrderNoSeries := OrderNoSeries_;
    end;
}

