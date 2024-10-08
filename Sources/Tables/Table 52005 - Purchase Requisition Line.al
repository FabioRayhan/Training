table 52005 "Purchase Requisition Line"
{
    Caption = 'Purchase Requisition Line';
    DataPerCompany = true;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Type"; Option)
        {
            OptionMembers = "Item","Service";
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Purchase Req. No."; Code[20])
        {
            Caption = 'Purchase Req. No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            TableRelation = "Purchase Requisition Table"."Expected Receipt Date";
            DataClassification = ToBeClassified;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;
        }
        field(8; "Bin Code"; Code[10])
        {
            Caption = 'Bin Code';
            DataClassification = ToBeClassified;
        }
        field(9; "Quantity"; Integer)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(10; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure".Code;
            DataClassification = ToBeClassified;
        }
        field(11; "Outstanding Quantity"; Integer)
        {
            Caption = 'Outstanding Quantity';
            DataClassification = ToBeClassified;
        }
        field(12; "Budget Model"; Decimal)
        {
            Caption = 'Budget Model';
            DataClassification = ToBeClassified;
        }
        field(13; "Ledger Account"; Code[10])
        {
            Caption = 'Ledger Account';
            DataClassification = ToBeClassified;
        }
        field(14; "Budget Status"; Option)
        {
            Caption = 'Budget Status';
            OptionMembers = "Confirmed","Not Confirmed";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.", "Purchase Req. No.", "Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Description")
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}