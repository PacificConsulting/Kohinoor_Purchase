pageextension 50202 ItemTrackingLinesExt extends "Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field("Back Pack/Display"; Rec."Back Pack/Display")
            {
                ApplicationArea = All;

            }


        }
        modify("Warranty Date")
        {
            Visible = true;
        }
        modify("Lot No.")
        {
            trigger OnAssistEdit()
            begin
                IF Rec."Source Type" = 5407 THEN BEGIN
                    ILE_.RESET;
                    ILE_.SETRANGE("Lot No.", Rec."Lot No.");
                    IF ILE_.FINDFIRST THEN BEGIN
                        Rec."Back Pack/Display" := ILE_."Back Pack/Display";
                    END;
                END;

                IF Rec."Source Type" = 37 THEN BEGIN
                    ILE_.RESET;
                    ILE_.SETRANGE("Lot No.", Rec."Lot No.");
                    IF ILE_.FINDFIRST THEN BEGIN
                        Rec."Back Pack/Display" := ILE_."Back Pack/Display";
                    END;
                END;
            end;
        }
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            var
                ILE: Record "Item Ledger Entry";
            begin
                //PCPL-0070 << START
                ILE.Reset();
                ILE.SetRange("Serial No.", Rec."Serial No.");
                if ILE.FindFirst() then
                    Rec."Back Pack/Display" := ILE."Back Pack/Display";
                CurrPage.SaveRecord();
                //PCPL-0070 << END
            end;
        }
    }

    actions
    {
        modify("Select Entries")
        {
            trigger OnAfterAction()
            var
                ILE: Record 32;
            begin
                ILE.RESET;
                ILE.SETRANGE("Lot No.", Rec."Lot No.");
                IF ILE.FINDFIRST THEN BEGIN
                    Rec."Back Pack/Display" := ILE."Back Pack/Display";
                    Rec.Modify();
                END;
            end;
        }
    }

    var
        myInt: Integer;
        ILE_: Record "Item Ledger Entry";
}