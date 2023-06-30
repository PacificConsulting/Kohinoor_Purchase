pageextension 50219 "Inventory Put away Ext" extends "Inventory Put-away"
{
    layout
    {
        addafter("External Document No.2")
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
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vehicle No. field.';
            }
        }
    }
    actions
    {
        modify("P&ost")
        {
            Trigger OnBeforeAction()
            begin
                Rec.TestField("LR No.");
                Rec.TestField("LR Date");
                Rec.TestField("Vehicle No.");
            end;
        }
    }
}
