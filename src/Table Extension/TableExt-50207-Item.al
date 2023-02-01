tableextension 50207 Item_Status extends Item
{
    fields
    {
        field(50201; "Item Status"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Status"."Item Code";
        }
    }

    var
        myInt: Integer;
}