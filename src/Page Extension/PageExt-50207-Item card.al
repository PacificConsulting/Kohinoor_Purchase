pageextension 50207 "Item card" extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Item Ststus"; Rec."Item Status")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}