pageextension 50075 "Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        addafter("Sorting Method")
        {

            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice No. field.';
                Editable = false;
            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Invoice Date field.';
                Editable = false;
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