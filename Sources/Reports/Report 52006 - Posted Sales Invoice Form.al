report 52006 "Posted Sales Invoice Form"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Sources/Reports/Report 52006- Posted Sales Invoices Form.rdlc';
    EnableExternalImages = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(companyImg; companyInformation.Picture) { }
            column(Invoice_No; "No.") { }
            column(Document_Date; "Document Date") { }
            column(Due_Date; "Due Date") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Customer_Name; "Sell-to Customer Name") { }
            column(Customer_Address; "Sell-to Address") { }
            column(Customer_Address2; "Sell-to Address 2") { }
            column(CustomerCityCountryAndPost; "Sell-to City" + ' - ' +
            "Sell-to Country/Region Code" + ', ' +
            "Sell-to Post Code")
            { }
            column(Sell_to_Contact; "Sell-to Contact") { }
            column(CompanyName; getCompanyName(companyInformation.Name)) { }
            column(CompanyAddress; getCompanyAddress(companyInformation.Address)) { }
            column(CompanyAddress2; getCompanyAddress2(companyInformation."Address 2")) { }
            column(CompanyCityCountryAndPost; companyInformation.City + ' - ' +
            getCompanyCountry(companyInformation."Country/Region Code") + ', ' +
            getCompanyPostCode(companyInformation."Post Code"))
            { }
            column(CompanyPhone; getCompanyPhone(companyInformation."Phone No.")) { }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(No_; "No.") { }
                column(Line_No_; "Line No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Shipment_No_; "Shipment No.") { }
                column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                column(Unit_Price_Excl_VAT; "Unit Price") { }
                column(VAT__; "VAT %") { }
                column(Line_Amount; "Line Amount") { }
                column(runningNoText; runningNoText) { }

                trigger OnAfterGetRecord()
                begin
                    if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::" " then begin
                        runningNo += 1;
                        runningNoText := Format(runningNo);
                    end else begin
                        runningNoText := '';
                    end;
                end;
            }

            trigger OnPreDataItem()
            var
            begin
                if (startingDate <> 0D) or (endingDate <> 0D) then
                    "Sales Invoice Header".SetRange("Document Date", startingDate, endingDate);
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Posted Sales Invoice Form';
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
    }

    trigger OnInitReport()
    begin
        companyInformation.get();
        companyInformation.CalcFields(Picture);
    end;

    procedure getCompanyName(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        company_Name: Text[100];
    begin
        companyTable.Reset();
        companyTable.SetRange(Name, companyName);
        if companyTable.FindFirst() then
            companyName := companyTable.Name;
        exit(companyName);
    end;

    procedure getCompanyAddress(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyAddress: Text[100];
    begin
        companyTable.Reset();
        companyTable.SetRange(Address, companyName);
        if companyTable.FindFirst() then
            companyAddress := companyTable.Address;
        exit(companyAddress);
    end;

    procedure getCompanyAddress2(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyAddress2: Text[100];
    begin
        companyTable.Reset();
        companyTable.SetRange("Address 2", companyName);
        if companyTable.FindFirst() then
            companyAddress2 := companyTable."Address 2";
        exit(companyAddress2);
    end;

    procedure getCompanyPostCode(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyPostCode: Code[20];
    begin
        companyTable.Reset();
        companyTable.SetRange("Post Code", companyName);
        if companyTable.FindFirst() then
            companyPostCode := companyTable."Post Code";
        exit(companyPostCode);
    end;

    procedure getCompanyCity(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyCity: Text[30];
    begin
        companyTable.Reset();
        companyTable.SetRange(City, companyName);
        if companyTable.FindFirst() then
            companyCity := companyTable.City;
        exit(companyCity);
    end;

    procedure getCompanyCountry(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyCountry: Code[10];
    begin
        companyTable.Reset();
        companyTable.SetRange("Country/Region Code", companyName);
        if companyTable.FindFirst() then
            companyCountry := companyTable."Country/Region Code";
        exit(companyCountry);
    end;

    procedure getCompanyPhone(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyPhone: Text[30];
    begin
        companyTable.Reset();
        companyTable.SetRange("Phone No.", companyName);
        if companyTable.FindFirst() then
            companyPhone := companyTable."Phone No.";
        exit(companyPhone);
    end;


    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(LayoutName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        companyInformation: Record "Company Information";
        generalLedger: Record "General Ledger Setup";
        startingDate: Date;
        endingDate: Date;
        runningNo: Integer;
        runningNoText: Text;
}