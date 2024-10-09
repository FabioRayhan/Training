pageextension 55001 "paymentJournal" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(ApplyEntries)
        {
            action("Payment Voucher")
            {
                ApplicationArea = all;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    genJournalLine: Record "Gen. Journal Line";
                begin
                    genJournalLine.Reset();
                    genJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    genJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    genJournalLine.SetRange("Source Code", Rec."Source Code");
                    genJournalLine.SetRange("Document No.", Rec."Document No.");
                    Report.Run(Report::"Payment Voucher", true, true, genJournalLine);
                end;
            }
        }
    }

    var
    // myInt: Page "Outgoing VAT";
}