tableextension 50077 Item_Status extends Item
{
    fields
    {
        field(50071; "Item Ststus"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Status"."Item Code";
        }
    }

    var
        myInt: Integer;
}