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
            field("EAN Code"; Rec."EAN Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EAN Code field.';
            }
            field(Demo; Rec.Demo)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Demo field.';
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