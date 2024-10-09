report 55003 "Payment Voucher"
{
    Extensible = false;
    DefaultLayout = RDLC;
    RDLCLayout = './Sources/Reports/Report 55003 - Payment Voucher.rdlc';
    // ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Document No.", "Posting Date";
            column(companyAddress; '') { }
            column(companyName; companyInformation.Name) { }
            column(address; companyInformation.Address) { }
            column(address2; companyInformation."Address 2") { }
            column(city; companyInformation.City + ' - ' + countryRegionName(companyInformation."Country/Region Code")) { }
            column(phone; companyInformation."Phone No.") { }
            column(fax; companyInformation."Fax No.") { }
            column(country; companyInformation."Country/Region Code") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_No_; "Document No.") { }
            column(Currency_Factor; "Currency Factor") { }
            column(Currency_Code; "Currency Code") { }
            column(Amount; Amount) { }
            column(Debit_Amount; "Debit Amount") { }
            column(Credit_Amount; "Credit Amount") { }
            column(Bal__Account_No_; "Bal. Account No.") { }
            column(Account_Name; accountName) { }
            column(Account_No_Coa; accountNoCoa) { }
            column(Account_Name_Coa; accountNameCOA) { }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.") { }
            column(External_Document_No_; externalDocumentInvoice) { }
            column(AmountInWords; AmountInWords) { }
            column(totalAmount; totalAmount) { }
            column(BalAccName; BalAccName) { }
            column(AccName; AccName) { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                page: Page "Payment Journal";
                postedPurchInvoice: Record "Purch. Inv. Header";
            begin
                accountName := '';
                externalDocumentInvoice := '';
                accountNoCOA := '';
                accountNameCOA := '';

                postedPurchInvoice.Reset();
                postedPurchInvoice.SetRange("No.", "Applies-to Doc. No.");
                if postedPurchInvoice.FindFirst() then
                    externalDocumentInvoice := postedPurchInvoice."Vendor Invoice No.";

                getNameAccount("Account No.", "Posting Group", accountName, accountNoCOA, accountNameCOA);
                GenJnlManagement.GetAccounts("Gen. Journal Line", AccName, BalAccName);
                sayingEnglish.FormatNoText(NoText, totalAmount, '');
                AmountInWords := NoText[1];
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("Debit Amount", '>0');
                totalAmount := 0;
                CalcSums("Debit Amount");
                totalAmount := "Debit Amount";
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
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;
                    // }
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

    trigger OnInitReport()
    begin
        companyInformation.get;
        companyInformation.CalcFields(Picture);
    end;

    procedure countryRegionName(countryCode: Code[10]): text
    var
        countryRegion: Record "Country/Region";
    begin
        if countryRegion.Get(countryCode) then
            exit(countryRegion.Name);
    end;

    local procedure getNameAccount(accountNo: Code[20]; postingGroup: Code[20]; var accountName: Text[150]; var accountCOA: Code[20]; var accountNameCOA: Text[150])
    var
        glAccountPosting: Record "G/L Account";
        glAccount: Record "G/L Account";
        customerAccount: Record Customer;
        vendorAccount: Record vendor;
        bankAccountAccount: Record "Bank Account";
        fixedAssetAccount: Record "Fixed Asset";
        icPartnerAccount: Record "IC Partner";
        employeeAccount: Record Employee;
        allocationAccount: Record "Allocation Account";
        customerPostingGroup: record "Customer Posting Group";
        vendorPostingGroup: record "vendor Posting Group";
        bankAccountPostingGroup: record "Bank Account Posting Group";
        fixedAssetPostingGroup: record "FA Posting Group";
        employeePostingGroup: record "Employee Posting Group";
    begin
        if glAccount.Get(accountNo) then begin
            accountName := glAccount.Name;
            accountNameCOA := glAccount.Name;
            accountCOA := glAccount."No.";
        end else
            if customerAccount.get(accountNo) then begin
                accountName := customerAccount.Name;
                if customerPostingGroup.Get(postingGroup) then begin
                    if glAccountPosting.Get(customerPostingGroup."Receivables Account") then
                        accountNameCOA := glAccountPosting.Name;
                    accountCOA := customerPostingGroup."Receivables Account";
                end;
            end else
                if vendorAccount.get(accountNo) then begin
                    accountName := vendorAccount.Name;
                    if vendorPostingGroup.Get(postingGroup) then begin
                        if glAccountPosting.Get(vendorPostingGroup."Payables Account") then
                            accountNameCOA := glAccountPosting.Name;
                        accountCOA := vendorPostingGroup."Payables Account";
                    end;
                end else
                    if bankAccountAccount.get(accountNo) then begin
                        accountName := bankAccountAccount.Name;
                        if bankAccountPostingGroup.Get(postingGroup) then begin
                            if glAccountPosting.Get(bankAccountPostingGroup."G/L Account No.") then
                                accountNameCOA := glAccountPosting.Name;
                            accountCOA := bankAccountPostingGroup."G/L Account No.";
                        end;
                    end else
                        if fixedAssetAccount.get(accountNo) then begin
                            accountName := fixedAssetAccount.Description;
                            if fixedAssetPostingGroup.Get(postingGroup) then begin
                                if glAccountPosting.Get(fixedAssetPostingGroup."Acquisition Cost Account") then
                                    accountNameCOA := glAccountPosting.Name;
                                accountCOA := fixedAssetPostingGroup."Acquisition Cost Account";
                            end;
                        end else
                            if icPartnerAccount.get(accountNo) then begin
                                accountName := fixedAssetAccount.Description;
                            end else
                                if employeeAccount.get(accountNo) then begin
                                    accountName := employeeAccount.FullName();
                                    if employeePostingGroup.Get(postingGroup) then begin
                                        if glAccountPosting.Get(employeePostingGroup."Payables Account") then
                                            accountNameCOA := glAccountPosting.Name;
                                        accountCOA := employeePostingGroup."Payables Account";
                                    end;
                                end else
                                    if allocationAccount.get(accountNo) then begin
                                        accountName := allocationAccount.Name;
                                    end;
    end;

    var
        companyInformation: Record "Company Information";
        // functionReport: Codeunit "Function Report";
        Payee: Text[150];
        accountName: Text[150];
        accountNameCOA: Text[150];
        accountNoCOA: Code[20];
        NoText: array[2] of Text;
        AmountInWords: Text;
        sayingEnglish: Codeunit "Saying English";
        totalAmount: Decimal;
        BalAccName: Text;
        AccName: Text;
        externalDocumentInvoice: Text;
        GenJnlManagement: Codeunit GenJnlManagement;
}