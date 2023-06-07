pageextension 50212 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        modify("Vehicle No.")
        {
            Editable = false;
        }
        addafter("Vendor Shipment No.")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the "Vendor Invoice No." field.';
            }
            field("LR No."; Rec."LR No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR No. field.';
            }
            field("LR Date"; Rec."LR Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR Date field.';
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
                Editable = false;
            }
        }
    }
}
