tableextension 50208 "Purchase Header " extends "Purchase Header"
{
    fields
    {
        field(50203; "LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50204; "LR Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50205; Attachment; Text[100])
        {
            Caption = 'Attachment';
            DataClassification = ToBeClassified;
        }
        field(50206; Remarks; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }
    procedure SendMail()
    begin
        PH.RESET;
        PH.SETRANGE("No.", Rec."No.");
        IF PH.FINDFIRST THEN;
        IF recVend.GET(rec."Buy-from Vendor No.") then;

        //Window.OPEN('Sending Mail              #1######\');

        Emailmessage.Create(recVend."E-Mail", 'Purchase Order Details ' + PH."No.", '', true);
        Recref.GetTable(PH);
        TempBlob.CreateOutStream(OutStr);
        Report.SaveAs(Report::Order, '', ReportFormat::Pdf, OutStr, Recref);
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
        Emailmessage.AppendToBody('<p><font face="Georgia"><BR><B>From Kohinoor</B></BR></font></p>');

        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        //Emailmessage.AppendToBody('<p><font face="Georgia"><BR><B>(Logistic Team)</B></BR></font></p>');
        Emailmessage.AppendToBody(FORMAT(Char));
        Emailmessage.AppendToBody(FORMAT(Char));
        EMail.Send(Emailmessage, Enum::"Email Scenario"::Default);
        // Window.UPDATE(1, STRSUBSTNO('%1', 'Mail Sent'));
        //Window.CLOSE;

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
        recVend: Record Vendor;
        Recref: RecordRef;


}