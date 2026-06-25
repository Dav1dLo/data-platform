# account_move__account_payment

## Source system
This table likely originates from an Odoo ERP system. The naming convention `account_move__account_payment` follows the standard Odoo pattern for a many-to-many join table linking accounting entries (moves) to payment records.

## Functional process 
This table supports the accounts receivable and accounts payable reconciliation process. It maps specific payment transactions to the corresponding invoice or journal entry, ensuring that financial records accurately reflect which payments have been applied to which invoices.

## Description
One row in this table represents a single association between an invoice (or accounting move) and a payment record. As a staging table, it provides a raw, landed representation of the link between these two entities, facilitating the reconciliation of financial transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_id | INTEGER | false | Foreign key to the invoice or account move record | Represents the target financial document being paid. |
| payment_id | INTEGER | false | Foreign key to the payment record | Represents the specific payment transaction applied. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`invoice_id`, `payment_id`).
- **Foreign keys (inferred):** 
    - `invoice_id` → `account_move.id`: Links to the accounting move or invoice record.
    - `payment_id` → `account_payment.id`: Links to the payment transaction record.
- **Natural keys (inferred):** The combination of (`invoice_id`, `payment_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no financial amounts or dates itself, only the relationship identifiers.
- Ensure joins to `account_move` and `account_payment` are handled as inner joins if you only require fully reconciled records.
- No soft-delete flags are present; assume this table reflects the current state of associations as captured during the last ingestion.