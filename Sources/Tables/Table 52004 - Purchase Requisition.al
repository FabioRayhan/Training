table 52004 "Purchase Requisition Table"
{
    Caption = 'Purchase Requisition Header';
    DataPerCompany = true;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Purchase Req. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document Type"; Option)
        {
            OptionMembers = "Order","Requisition";
            DataClassification = ToBeClassified;
        }
        field(3; "Fixed Asset"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Location Code"; Code[10])
        {
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;
        }
        field(5; "POS Admin Creator ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "POS Admin Creator Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Schedule Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Expected Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Is POS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Purpose"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Accounting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Currency"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "User Request"; Option)
        {
            OptionMembers = "SYSTEM [BOT]","DEV";
            DataClassification = ToBeClassified;
        }
        field(15; "Worker"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Status Document"; Option)
        {
            OptionMembers = "Draft","Submitted","Approved";
            DataClassification = ToBeClassified;
        }
        field(18; "Budget Status"; Option)
        {
            OptionMembers = "Confirmed","Not Confirmed";
            DataClassification = ToBeClassified;
        }
        field(19; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Type"; Option)
        {
            OptionMembers = "Item","Service";
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Purchase Req. No.", "Type")
        {
            Clustered = true;
        }
    }
}
