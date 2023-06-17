pageextension 50218 "Posted Purch. Invoice Subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Gen. Prod. Posting Group")
        {

            field("Vendor Model No."; Rec."Vendor Model No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Model No. field.';
            }
        }
    }
}
