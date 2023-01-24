pageextension 50072 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        addafter("Expiration Date")
        {
            field("Back Pack/Display"; Rec."Back Pack/Display")
            {
                ApplicationArea = All;
            }
        }
        modify("Lot No.")
        {
            trigger OnAssistEdit()
            var
                ILE: Record 32;
            Begin
                if Rec."Source Type" = 37 then begin
                    ILE.RESET;
                    ILE.SETRANGE("Lot No.", Rec."Lot No.");
                    IF ILE.FINDFIRST THEN BEGIN
                        Rec."Back Pack/Display" := ILE."Back Pack/Display";
                    END;
                end;
            End;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}