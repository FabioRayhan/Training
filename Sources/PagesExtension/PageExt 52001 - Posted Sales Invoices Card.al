pageextension 52005 "PS Invoices Extension" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addbefore("Update Document")
        {
            action("Print Kwitansi")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    POHeader: Record "Sales Invoice Header";
                begin
                    CurrPage.SetSelectionFilter(POHeader);
                    Report.Run(Report::"Posted Sales Invoices Report", true, true, POHeader);
                end;
            }
        }

        addbefore("Update Document")
        {
            action("Print Form")
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    POHeader: Record "Sales Invoice Header";
                begin
                    CurrPage.SetSelectionFilter(POHeader);
                    Report.Run(Report::"Posted Sales Invoice Form", true, true, POHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}