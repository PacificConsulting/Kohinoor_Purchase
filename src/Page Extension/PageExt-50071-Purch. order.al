pageextension 50071 "Purch. Order" extends "Purchase Order"
{
    layout
    {

    }

    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Vendor Invoice No.");
                rec.TestField("Document Date");
            end;
        }
        addafter("Post and &Print")
        {
            action("Send Mail")
            {
                Caption = 'Send Mail';
                Image = SendMail;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF Not Confirm('Do you want to send the mail', true) then
                        exit;
                    SendMail;
                end;
            }
        }
    }
    procedure SendMail()
    begin
        PH.RESET;
        PH.SETRANGE("No.", Rec."No.");
        IF PH.FINDFIRST THEN;
        IF recCust.GET(rec."Sell-to Customer No.") then;
        Window.OPEN(
                     'Sending Mail              #1######\');

        Emailmessage.Create(recCust."E-Mail", 'Purchase Order Details ' + PH."No.", '', true);
        Recref.GetTable(PH);
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::"Standard Purchase - Order", '', ReportFormat::Pdf, OutStr, Recref);
        TempBlob.CreateInStream(InStr);
        Emailmessage.AddAttachment('Purchase Order.pdf', '.pdf', InStr);



        Emailmessage.AppendToBody('<p><font face="Georgia">Dear <B>Sir,</B></font></p>');
        Char := 13;
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<p><font face="Georgia"> <B>!!!Greetings!!!</B></font></p>');
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Please find attachment</BR></font></p>');
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Thanking you,</BR></font></p>');
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR>Warm Regards,</BR></font></p>');
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR><B>For K-TECH (INDIA) LIMITED</B></BR></font></p>');

        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR><B>(Logistic Team)</B></BR></font></p>');
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        Window.UPDATE(1, STRSUBSTNO('%1', 'Mail Sent'));
        EMail.Send(Emailmessage, Enum::"Email Scenario"::Default);
        Window.CLOSE;

    end;

    var
        Email: Codeunit Email;
        EmailMessage: codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        OutStr: OutStream;
        Instr: InStream;
        Window: Dialog;
        Char: Char;
        PH: Record 38;
        recCust: Record 18;
        Recref: RecordRef;
}