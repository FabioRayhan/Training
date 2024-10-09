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
            //column()
            column(Invoice_No; "No.") { }
            column(Document_Date; "Document Date") { }
            column(Customer_Name; "Sell-to Customer Name") { }
            column(Customer_Address; "Sell-to Address") { }
            column(Amount; "Amount Including VAT") { }
            column(Currency_Code; "Currency Code") { }
            column(getCompanyAddress; getCompanyAddress(companyInfomation.Address)) { }
            column(getCompanyAddress2; getCompanyAddress2(companyInfomation."Address 2")) { }
            column(getCompanyPostCode; getCompanyPostCode(companyInfomation."Post Code")) { }
            column(getCompanyCity; getCompanyCity(companyInfomation.City)) { }
            column(getCompanyCountry; getCompanyCountry(companyInfomation."Country/Region Code")) { }
            column(getCompanyPhone; getCompanyPhone(companyInfomation."Phone No.")) { }
            column(getCompanyEmail; getCompanyEmail(companyInfomation."E-Mail")) { }
            column(getEmployeeName; getEmployeeName("Sales Invoice Header"."No.")) { }
            column(getEmployeeTitle; getEmployeeTitle("Sales Invoice Header"."No.")) { }
        }
    }

    procedure getCompanyAddress(companyName: Text[100]): Text
    var
        companyTable: Record "Company Information";
        companyAddress: Text[100];
    begin
        companyTable.Reset();
        companyTable.SetRange(Address, companyName);
        if companyTable.FindFirst() then
            companyAddress := companyTable."Address";
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
        employeeTable: Record Vendor;
        employeeName: Record Employee;
    begin
        employeeNameProcedure := '';
        employeeTable.Reset();
        employeeTable.SetRange("No.", employeeNo);
        if employeeTable.FindFirst() then begin
            employeeName.Reset();
            employeeName.SetRange("No.", employeeTable."No.");
            if employeeName.FindFirst() then begin
                employeeNameProcedure := employeeName."First Name";
            end;
        end;
        exit(employeeNameProcedure);
    end;

    procedure getEmployeeTitle(employeeNo: Code[20]): Text
    var
        employeeTable: Record Vendor;
        employeeTitle: Record Employee;
    begin
        employeeTitleProcedure := '';
        employeeTable.Reset();
        employeeTable.SetRange("No.", employeeNo);
        if employeeTable.FindFirst() then begin
            employeeTitle.Reset();
            employeeTitle.SetRange("No.", employeeTable."No.");
            if employeeTitle.FindFirst() then begin
                employeeNameProcedure := employeeTitle."Job Title";
            end;
        end;
        exit(employeeNameProcedure);
    end;

    trigger OnInitReport()
    begin
        companyInfomation.get();
        companyInfomation.CalcFields(Picture);
    end;


    // requestpage
    // {
    //     AboutTitle = 'Teaching tip title';
    //     AboutText = 'Teaching tip content';
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

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
        companyAddress: Text[100];
        companyAddress2: Text[50];
        companyPostCode: Code[20];
        companyCity: Text[30];
        companyCountry: Code[10];
        companyPhone: Text[30];
        companyEmail: Text[80];
        employeeNameProcedure: Text[100];
        employeeTitleProcedure: Text[100];
}