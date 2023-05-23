pageextension 50212 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Vendor Shipment No.")
        {


            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the "Vendor Invoice No." field.';
            }
        }
    }
}
