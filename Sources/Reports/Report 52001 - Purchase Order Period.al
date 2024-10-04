report 52001 "Purchase Order Period"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Sources/Reports/Report 52001 - Purchase Order Period.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Document_Date; "Document Date") { }
            column(No_; "No.") { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if (startingDate <> 0D) or (endingDate <> 0D) then
                    "Purchase Header".SetRange("Document Date", startingDate, endingDate);
            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(startingDate; startingDate)
                    {
                        ApplicationArea = all;
                    }
                    field(endingDate; endingDate)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
    }

    var
        startingDate: Date;
        endingDate: Date;
}