pageextension 52003 "PO Period Extension" extends "Purchase Order"
{
    trigger OnOpenPage();
    begin
        report.Run(Report::"Purchase Order Period2");
    end;
}