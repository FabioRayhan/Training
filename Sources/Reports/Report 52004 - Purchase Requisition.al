report 52004 "Purchase Requisition"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Sources/Reports/Report 52004 - Purchase Requisition.rdlc';

    dataset
    {
        dataitem("Purchase Requisition Table"; "Purchase Requisition Table")
        {
            column(Purchase_Req__No_; "Purchase Req. No.") { }
            column(Fixed_Asset; "Fixed Asset") { }
            column(Location_Code; "Location Code") { }
            column(Schedule_Date; "Schedule Date") { }
            column(Expected_Receipt_Date; "Expected Receipt Date") { }
            column(Request_Date; "Request Date") { }
            column(Currency; Currency) { }
            column(User_Request; "User Request") { }
            column(Worker; Worker) { }
            column(Total_Amount; "Total Amount") { }
            column(Status_Document; "Status Document") { }
            column(Budget_Status; "Budget Status") { }

            dataitem("Purchase Requisition Line"; "Purchase Requisition Line")
            {
                DataItemLink = "No." = field("Purchase Req. No.");
                column(Item_No_; "Item No.") { }
                column(No_; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Budget_Model; "Budget Model") { }
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if (startingDate <> 0D) or (endingDate <> 0D) then
                    "Purchase Requisition Table".SetRange("Request Date", startingDate, endingDate);
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Purchase Requisition';
        AboutText = 'Choose the date';
        layout
        {
            area(Content)
            {
                group(Filter)
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

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        startingDate: Date;
        endingDate: Date;
}