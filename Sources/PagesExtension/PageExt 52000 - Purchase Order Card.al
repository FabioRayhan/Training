pageextension 52000 "PO Card Extension" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Print")
        {
            action("Print Custom")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    POHeader: Record "Purchase Header";
                begin
                    CurrPage.SetSelectionFilter(POHeader);
                    Report.Run(Report::"Purchase Order Custom1", true, true, POHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}