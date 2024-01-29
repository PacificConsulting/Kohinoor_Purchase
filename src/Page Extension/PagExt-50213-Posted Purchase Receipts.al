pageextension 50213 "Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    layout
    {
        addafter("Location Code")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
            }
            field("LR Date"; Rec."LR Date")
            {
                ApplicationArea = all;
            }
        }

    }
}
