report 52000 "Purchase Order Custom1"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Sources/Reports/Report 52000 - Purchase Order Custom.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(companyName; companyInformation.Name) { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Contact; "Buy-from Contact") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_City; "Buy-from City") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Vendor_Order_No_; "Vendor Order No.") { }
            column(No_Header; "No.") { }
            column(Document_Date; "Document Date") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Prices_Including_VAT; "Prices Including VAT") { }
            column(getCountryName; getCountryName("Purchase Header"."Pay-to Country/Region Code")) { }
            column(getPaymentTerms; getPaymentTerms("Purchase Header"."Payment Terms Code")) { }
            column(getShipmentMethod; getShipmentMethod("Purchase Header"."Shipment Method Code")) { }
            column(getPurchaserName; getPurchaserName("Purchase Header"."Buy-from Vendor No.")) { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(No_; "No.") { }
                column(Description; Description) { }
                column(getLocationName; "getLocationName"("Location Code")) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(VAT__; "VAT %") { }
                column(Line_Amount; "Line Amount") { }
                column(CalculateVAT; CalculateVAT("Purchase Header")) { }
                column(CalculateTotalAmount; CalculateTotalAmount("Purchase Header")) { }
                column(TotalVAT; CalculateTotalAmount("Purchase Header") - CalculateVAT("Purchase Header")) { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(VAT_Base_Amount; "VAT Base Amount") { }
                column(GetLineAmountInclVAT; GetLineAmountInclVAT) { }
            }
            trigger OnAfterGetRecord()
            var
                vendorTable: Record Vendor;
                salesPersonPurchaser: Record "Salesperson/Purchaser";
            begin
                purchaserName := '';

                vendorTable.Reset();
                vendorTable.SetRange("No.", "Purchase Header"."Buy-from Vendor No.");
                if vendorTable.FindFirst() then begin
                    salesPersonPurchaser.Reset();
                    salesPersonPurchaser.SetRange(Code, vendorTable."Purchaser Code");
                    if salesPersonPurchaser.FindFirst() then begin
                        purchaserName := salesPersonPurchaser.Name;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if (startingDate <> 0D) or (endingDate <> 0D) then
                    "Purchase Header".SetRange("Document Date", startingDate, endingDate);
            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

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

        actions
        {
            // area(processing)
            // {
            //     action(LayoutName)
            //     {
            //         ApplicationArea = All;

            //     }
            // }
        }
    }

    // rendering
    // {
    //      layout(LayoutName)
    //      {
    //          Type = Excel;
    //          LayoutFile = 'mySpreadsheet.xlsx';
    //      }
    // }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        companyInformation.get();
        companyInformation.CalcFields(Picture);
    end;

    procedure getPurchaserName(vendorNo: Code[20]): Text
    var
        vendorTable: Record Vendor;
        salesPersonPurchaser: Record "Salesperson/Purchaser";
    begin
        purchaserNameProcedure := '';

        vendorTable.Reset();
        vendorTable.SetRange("No.", vendorNo);
        if vendorTable.FindFirst() then begin
            salesPersonPurchaser.Reset();
            salesPersonPurchaser.SetRange(Code, vendorTable."Purchaser Code");
            if salesPersonPurchaser.FindFirst() then begin
                purchaserNameProcedure := salesPersonPurchaser.Name;
            end;
        end;
        exit(purchaserNameProcedure);
    end;

    procedure getCountryName(countryCode: Code[20]): Text
    var
        countryTable: Record "Country/Region";
        countryName: Text[20];
    begin
        countryTable.Reset();
        countryTable.SetRange(Code, countryCode);
        if countryTable.FindFirst() then
            countryName := countryTable."Name";
        exit(countryName);
    end;

    procedure getPaymentTerms(paymentCode: Code[20]): Text
    var
        paymentTermsTable: Record "Payment Terms";
        paymentDesc: Text[20];
    begin
        paymentTermsTable.Reset();
        paymentTermsTable.SetRange(Code, paymentCode);
        if paymentTermsTable.FindFirst() then
            paymentDesc := paymentTermsTable.Description;
        exit(paymentDesc);
    end;

    procedure getShipmentMethod(shipmentCode: Code[20]): Text
    var
        shipmentTable: Record "Payment Terms";
        shipmentDesc: Text[20];
    begin
        shipmentTable.Reset();
        shipmentTable.SetRange(Code, shipmentCode);
        if shipmentTable.FindFirst() then
            shipmentDesc := shipmentTable.Description;
        exit(shipmentDesc);
    end;

    procedure getLocationName(locationCode: Code[20]): Text
    var
        locationTable: Record Location;
        locationName: Text[20];
    begin
        locationTable.Reset();
        locationTable.SetRange(Code, locationCode);
        if locationTable.FindFirst() then
            locationName := locationTable."Name";
        exit(locationName);
    end;

    procedure CalculateVAT(purchaseHeader: Record "Purchase Header"): Decimal
    var
        vatRate: Decimal;
        totalAmount: Decimal;
        PurchaseLine1: Record "Purchase Line";
    begin
        PurchaseLine1.Reset();
        PurchaseLine1.SetRange("Document No.", purchaseHeader."No.");
        PurchaseLine1.SetRange("Document Type", purchaseHeader."Document Type");
        if PurchaseLine1.FindFirst() then begin
            repeat
                totalAmount += PurchaseLine1."VAT Base Amount";
            until PurchaseLine1.Next() = 0;
        end;
        exit(totalAmount);
    end;

    procedure CalculateTotalAmount(purchaseHeader: Record "Purchase Header"): Decimal
    var
        vatRate: Decimal;
        totalAmount: Decimal;
        PurchaseLine1: Record "Purchase Line";
    begin
        PurchaseLine1.Reset();
        PurchaseLine1.SetRange("Document No.", purchaseHeader."No.");
        PurchaseLine1.SetRange("Document Type", purchaseHeader."Document Type");
        if PurchaseLine1.FindFirst() then begin
            repeat
                totalAmount += PurchaseLine1."Amount Including VAT";
            until PurchaseLine1.Next() = 0;
        end;
        exit(totalAmount);
    end;

    var
        companyInformation: Record "Company Information";
        purchaserName: Text[150];
        countryName: Text[150];
        shipmentDesc: Text[150];
        paymentDesc: Text[150];
        locationName: Text[150];
        purchaserNameProcedure: Text[150];
        startingDate: Date;
        endingDate: Date;
        vatRate: Decimal;
        vatAmount: Decimal;
        baseAmount: Decimal;
        totalIncludingVAT: Decimal;
        getLineAmountIncludeVAT: Decimal;
}