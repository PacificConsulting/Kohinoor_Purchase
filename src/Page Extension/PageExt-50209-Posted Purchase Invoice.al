pageextension 50209 POsted_Purchase_Invoice_Ext extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action("Credit Note")
            {
                ApplicationArea = all;
                Promoted = true;
                Image = Print;
                trigger OnAction()
                var
                    PIH: Record "Purch. Inv. Header";
                begin
                    PIH.Reset();
                    PIH.SetRange("No.", rec."No.");
                    if PIH.FindFirst() then
                        Report.RunModal(50005, true, false, PIH);
                end;
            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}