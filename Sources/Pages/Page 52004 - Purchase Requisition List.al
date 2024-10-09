page 52004 "Purchase Requisition List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Requisition Table";
    CardPageId = "Purchase Requisition";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Purchase Req. No."; Rec."Purchase Req. No.")
                {
                    Caption = 'No.';
                    TableRelation = "Purchase Requisition Table"."Purchase Req. No.";
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field(Worker; Rec.Worker)
                {
                    ApplicationArea = All;
                }
                field("User Request"; Rec."User Request")
                {
                    Caption = 'Created By';
                    ApplicationArea = All;
                }
                field("Is POS"; Rec."Is POS")
                {
                    ApplicationArea = All;
                }
                field("Status Document"; Rec."Status Document")
                {
                    ApplicationArea = All;
                }
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
                Image = SendApprovalRequest;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Status Document" := Rec."Status Document"::Submitted;
                    Rec.Modify();
                end;
            }
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                trigger OnAction()
                begin
                    Rec."Status Document" := Rec."Status Document"::Approved;
                    Rec.Modify();
                end;
            }
            action(Draft)
            {
                Caption = 'Draft';
                Image = Action;
                trigger OnAction()
                begin
                    Rec."Status Document" := Rec."Status Document"::Draft;
                    Rec.Modify();
                end;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = Print;

            }
        }
    }

    var
        myInt: Integer;
}