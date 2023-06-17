tableextension 50216 "Entry Summary" extends "Entry Summary"
{
    fields
    {
        field(50201; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Ledger Entry"."Posting Date" where("Serial No." = field("Serial No.")));
        }
    }
}
