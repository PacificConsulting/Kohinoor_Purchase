pageextension 50214 "Purchase invoice Card" extends "Purchase Invoice"
{
    layout
    {
        addafter("Vendor Invoice No.")
        {

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
        }
    }
}
