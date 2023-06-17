pageextension 50216 "Item Tracking Summary" extends "Item Tracking Summary"
{
    layout
    {
        addafter("Total Available Quantity")
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting Date field.';
            }
        }
    }
}
