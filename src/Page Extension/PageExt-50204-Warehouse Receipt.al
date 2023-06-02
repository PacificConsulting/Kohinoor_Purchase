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
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vehicle No. field.';
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }
        }
    }

    actions
    {
        modify("Post Receipt")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Rec.TestField("Vendor Invoice No.");
                Rec.TestField("LR No.");
                Rec.TestField("LR Date");
                Rec.TestField(Remarks);
            end;
        }
    }

    var
        myInt: Integer;
}