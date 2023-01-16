pageextension 50073 ItemTrackingLinesExt extends "Item Tracking Lines"
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
        // Add changes to page actions here 
    }

    var
        myInt: Integer;
        ILE_: Record "Item Ledger Entry";
}