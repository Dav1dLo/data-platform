# account_move_account_move_send_batch_wizard_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_move_account_move_send_batch_wizard_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link business objects (in this case, `account_move` journal entries) to transient wizard models used for batch processing (sending/emailing invoices).

## Functional process 
This table supports the "Customer Invoicing" or "Accounts Receivable" business process. It acts as a join table for the batch-sending wizard, allowing users to select multiple journal entries (`account_move`) and process them together (e.g., bulk emailing or printing) via a specific wizard instance (`account_move_send_batch_wizard`).

## Description
One row in this table represents a single association between a specific journal entry and a batch-processing wizard session. It is a raw landing copy of an Odoo relational link table, used to maintain the state of bulk operations before they are committed to the ledger.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_send_batch_wizard_id | INTEGER | false | Foreign key to the batch wizard instance | Links to the transient wizard session. |
| account_move_id | INTEGER | false | Foreign key to the journal entry | Identifies the specific invoice or move being processed. |

## Keys

- **Primary key (inferred):** The combination of `(account_move_send_batch_wizard_id, account_move_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_move_send_batch_wizard_id` → `account_move_send_batch_wizard.id` (Inferred from Odoo naming convention).
    - `account_move_id` → `account_move.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a technical join table; it does not contain business logic or timestamps itself.
- There are no sensitive columns (PII) in this specific table.
- As a staging table for a transient wizard, data here may be short-lived and purged by the source system once the batch process is completed.
- Ensure joins to `account_move` are handled carefully, as this table only tracks the association, not the status of the move itself.