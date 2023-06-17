pageextension 50217 "Purchase order Subform pur" extends "Purchase Order Subform"
{
    layout
    {
        addafter("HSN/SAC Code")
        {

            field("Vendor Model No."; Rec."Vendor Model No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Model No. field.';
            }
        }
    }
}

