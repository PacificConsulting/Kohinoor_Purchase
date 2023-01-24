pageextension 50073 ItemTrackingLinesExt extends "Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field("Back Pack/Display"; Rec."Back Pack/Display")
            {
                ApplicationArea = All;
                // trigger OnAssistEdit()
                // var
                //     ILE: record 32;
                // Begin
                //     if Rec."Source Type" = 37 then begin
                //         ILE.RESET;
                //         ILE.SETRANGE("Lot No.", Rec."Lot No.");
                //         IF ILE.FINDFIRST THEN BEGIN
                //             Rec."Back Pack/Display" := ILE."Back Pack/Display";
                //         END;
                //     end;
                // End;
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