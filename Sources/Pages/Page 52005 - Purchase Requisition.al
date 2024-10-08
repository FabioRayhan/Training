page 52005 "Purchase Requisition"
{
    PageType = Document;
    ApplicationArea = All;
    Caption = 'Purchase Requisition Header';
    SourceTable = "Purchase Requisition Table";
    Editable = true;

    layout
    {
        area(Content)
        {
            group(Group)
            {
                Caption = 'General';
                field("Purchase Req. No."; Rec."Purchase Req. No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Purchase Requisition Table"."Purchase Req. No.";
                    ToolTip = 'Displays The Purchase Requisition Number.';
                }
                field("Fixed Asset"; Rec."Fixed Asset")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("POS Admin Creator ID"; Rec."POS Admin Creator ID")
                {
                    ApplicationArea = All;
                }
                field("POS Admin Creator Name"; Rec."POS Admin Creator Name")
                {
                    ApplicationArea = All;
                }
                field("Schedule Date"; Rec."Schedule Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Is POS"; Rec."Is POS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if this requisition is related to POS';
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Accounting Date"; Rec."Accounting Date")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field("User Request"; Rec."User Request")
                {
                    ApplicationArea = All;
                }
                field(Worker; Rec.Worker)
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Status Document"; Rec."Status Document")
                {
                    ApplicationArea = All;
                    ToolTip = 'The current status of the purchase requisition';
                }
                field("Budget Status"; Rec."Budget Status")
                {
                    ApplicationArea = All;
                }

            }
            part(lines; "Purchase Requisition Subform")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Purchase Req. No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Caption = 'Submit';
                ToolTip = 'Submit the requisition for approval.';
                trigger OnAction()
                begin
                    Rec."Status Document" := Rec."Status Document"::Submitted;
                    Rec.Modify();
                end;
            }

            action(Approve)
            {
                Caption = 'Approve';
                ToolTip = 'Approve the requisition.';
                trigger OnAction()
                begin
                    Rec."Status Document" := Rec."Status Document"::Approved;
                    Rec.Modify(true);
                end;
            }
        }
    }

    var
        myInt: Integer;
}