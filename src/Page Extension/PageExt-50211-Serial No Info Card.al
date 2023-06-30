pageextension 50211 "Serial No. Info Card" extends "Serial No. Information Card"
{
    layout
    {
        addafter("Variant Code")
        {
            field("Back Pack Dispaly"; Rec."Back Pack Dispaly")
            {
                ApplicationArea = ALL;
            }
            field("Inward Date"; Rec."Inward Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inward Date field.';
            }
        }
    }
}
