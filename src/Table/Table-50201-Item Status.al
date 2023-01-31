table 50201 "Item Status"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';


        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Item Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}