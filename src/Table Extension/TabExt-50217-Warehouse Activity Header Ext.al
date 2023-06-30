tableextension 50217 "Warehouse Activity Header Ext" extends "Warehouse Activity Header"
{
    fields
    {
        field(50201; "LR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50202; "LR Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}
