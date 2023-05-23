pageextension 50210 "Purchase Order Mail" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Post)
        {
            action("Sent Mail")
            {
                ApplicationArea = all;
                PromotedCategory = New;
                PromotedIsBig = true;
                Promoted = true;
                trigger OnAction()
                var
                    PH: Record 38;
                begin
                    Rec.SendMail();
                end;

            }
        }
    }

    var
        myInt: Integer;
}