pageextension 50204 "Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        addafter("Sorting Method")
        {

            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice No. field.';

            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice Date field.';

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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}