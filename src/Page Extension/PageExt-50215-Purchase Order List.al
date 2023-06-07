pageextension 50215 "Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        addafter(Status)
        {

            field(Receive; Rec.Receive)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Receive field.';
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
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vendor invoice number.';
            }
            field("Vehicle No."; Rec."Vehicle No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the vehicle number on the sales document.';
            }
        }

    }
    actions
    {
        addfirst(processing)
        {
            action("Bulk Upload Data")
            {
                Caption = 'Bulk Upload Data';
                PromotedCategory = New;
                PromotedIsBig = true;
                Promoted = true;
                Image = UpdateXML;
                ApplicationArea = all;
                trigger OnAction()
                var
                    PO: XmlPort 50203;
                begin
                    Po.Run();
                end;
            }
        }
    }

}
