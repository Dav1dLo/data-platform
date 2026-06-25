# account_payment_register_move_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_payment_register_move_line_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link a payment registration wizard process to specific accounting move lines.

## Functional process 
This table supports the "Accounts Payable/Receivable" payment reconciliation process. It acts as a join table that tracks which specific accounting journal entries (move lines) are being processed or cleared by a specific payment registration wizard instance.

## Description
One row represents a single association between a payment registration wizard session and an accounting move line. It serves as a raw landing copy of the relationship table used during the payment reconciliation workflow to maintain the link between the wizard and the underlying ledger entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the payment registration wizard instance | Represents the specific execution of the payment process. |
| line_id | INTEGER | false | Foreign key to the accounting move line | Represents the specific ledger entry being reconciled. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(wizard_id, line_id)`.
- **Foreign keys (inferred):** 
    - `wizard_id` → `account_payment_register.id` (Guess: links to the parent wizard record).
    - `line_id` → `account_move_line.id` (Guess: links to the specific accounting entry).
- **Natural keys (inferred):** The combination of `(wizard_id, line_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- As a staging table, it may be truncated and reloaded frequently depending on the Odoo ingestion strategy.
- There are no timestamps or audit columns present; rely on the parent tables for temporal context.