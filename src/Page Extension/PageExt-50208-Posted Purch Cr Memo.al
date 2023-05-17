pageextension 50208 Posted_Purch_Cr_Memo_Ext extends "Posted Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Print")
        {
            action("Debit Note")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                trigger OnAction()
                var
                    PCMH: Record "Purch. Cr. Memo Hdr.";
                begin
                    PCMH.Reset();
                    PCMH.SetRange("No.", rec."No.");
                    if PCMH.FindFirst() then
                        Report.RunModal(50004, true, false, PCMH);
                end;
            }
        }

    }

    var
        myInt: Integer;
}