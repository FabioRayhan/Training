report 52003 "Purchase Order Period2"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './Sources/Reports/Report 52003 - Purchase Order Period2.docx';
    //tesss
    // 123 test 
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(Document_Date; "Purchase Header"."Document Date") { }
                column(Document_No; "Purchase Header"."No.") { }
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

    // rendering
    // {
    //     layout(Period1)
    //     {
    //         Type = Excel;
    //         LayoutFile = './Sources/Reports/Report 52002 - Purchase Order Period1.xlsx';
    //     }
    // }

    var
        startingDate: Date;
        endingDate: Date;
}