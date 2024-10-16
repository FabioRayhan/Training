report 52005 "Posted Sales Invoices Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Sources/Reports/Report 52005 - Posted Sales Invoices Report.rdlc';
    EnableExternalImages = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(companyImg; companyInfomation.Picture) { }
            column(Invoice_No; "No.") { }
            column(Document_Date; "Document Date") { }
            column(Customer_Name; "Sell-to Customer Name") { }
            column(Customer_Address; "Sell-to Address") { }
            column(Amount; "Amount Including VAT") { }
            column(AmountInWords; AmountInWords) { }
            column(Currency_Code; "Currency Code") { }
            column(LCYCode; LCYCode) { }
            column(getCurrency; getCurrency(GLSetup."LCY Code")) { }
            column(getCompanyAddress; getCompanyAddress(companyInfomation.Address)) { }
            column(getCompanyAddress2; getCompanyAddress2(companyInfomation."Address 2")) { }
            column(getCompanyPostCode; getCompanyPostCode(companyInfomation."Post Code")) { }
            column(getCompanyCity; companyInfomation.City + ' - ' + getCompanyCountry(companyInfomation."Country/Region Code")) { }
            column(getCompanyCountry; getCompanyCountry(companyInfomation."Country/Region Code")) { }
            column(getCompanyPhone; getCompanyPhone(companyInfomation."Phone No.")) { }
            column(getCompanyEmail; getCompanyEmail(companyInfomation."E-Mail")) { }
            column(getEmployeeName; getEmployeeName(employeeInformation."First Name")) { }
            column(getEmployeeTitle; getEmployeeTitle(employeeInformation."Job Title")) { }

            trigger OnAfterGetRecord()
            var
            begin
                AmountInWords := '';
                "Sales Invoice Header".CalcFields("Amount Including VAT");
                sayingEnglish.FormatNoText(NoText, "Sales Invoice Header"."Amount Including VAT", '');
                AmountInWords := NoText[1];
            end;

            trigger OnPreDataItem()
            var
            begin
                if GLSetup.Get() then
                    LCYCode := GLSetup."LCY Code";
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Posted Sales Invoice';
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

    procedure getCurrency(lcyCode: Code[10]): Text
    var
        ledgerTable: Record "General Ledger Setup";
        currencyCode: Text[100];
    begin
        ledgerTable.Reset();
        ledgerTable.SetRange("LCY Code", lcyCode);
        if ledgerTable.FindFirst() then
            currencyCode := ledgerTable."LCY Code";
        exit(currencyCode);
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

    procedure getCompanyEmail(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyEmail: Text[80];
    begin
        companyTable.Reset();
        companyTable.SetRange("E-Mail", companyName);
        if companyTable.FindFirst() then
            companyEmail := companyTable."E-Mail";
        exit(companyEmail);
    end;

    procedure getEmployeeName(employeeNo: Code[20]): Text
    var
        employeeTable: Record Employee;
        employeeName: Text[30];
    begin
        employeeTable.Reset();
        employeeTable.SetRange("First Name", employeeNo);
        if employeeTable.FindFirst() then
            employeeName := employeeTable."First Name";
        exit(employeeName);
    end;

    procedure getEmployeeTitle(employeeNo: Code[20]): Text
    var
        employeeTable: Record Employee;
        employeeTitle: Text[30];
    begin
        employeeTable.Reset();
        employeeTable.SetRange("Job Title", employeeNo);
        if employeeTable.FindFirst() then
            employeeTitle := employeeTable."Job Title";
        exit(employeeTitle);
    end;

    trigger OnInitReport()
    begin
        companyInfomation.get();
        companyInfomation.CalcFields(Picture);
    end;

    // actions
    // {
    //     area(processing)
    //     {
    //         action(LayoutName)
    //         {
    //             ApplicationArea = All;

    //         }
    //     }
    // }
    //}

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = Excel;
    //         LayoutFile = 'mySpreadsheet.xlsx';
    //     }
    // }

    var
        companyInfomation: Record "Company Information";
        employeeInformation: Record Employee;
        GLSetup: Record "General Ledger Setup";
        LCYCode: Code[10];
        AmountInWords: Text;
        NoText: array[2] of Text;
        sayingEnglish: Codeunit "Saying English";
        startingDate: Date;
        endingDate: Date;
}