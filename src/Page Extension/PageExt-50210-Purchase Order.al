pageextension 50210 "Purchase Order Mail" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {

            field(Attachment; Rec.Attachment)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Attachment field.';
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
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
        modify(Release)
        {
            trigger OnAfterAction()
            var
                Vend: Record Vendor;
                PL: record "Purchase Line";
            begin
                If Rec."Document Type" = Rec."Document Type"::Order then begin
                    IF Rec.Status = Rec.Status::Released then begin
                        IF Vend.get(Rec."Buy-from Vendor No.") then
                            if Vend."E-Mail" = '' then
                                Message('Vendor Email is blank so system will not send the mail')
                            else
                                IF Confirm('Do you want to send the mail', true) then
                                    Rec.SendMail();
                        //end;////
                    end;
                end;
            end;
        }
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