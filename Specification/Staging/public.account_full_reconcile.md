# account_full_reconcile

## Source system
The table likely originates from an Odoo ERP system. The naming convention (e.g., `exchange_move_id`, `create_uid`, `write_uid`) and the specific pattern of using `_seq` sequences for primary keys are characteristic of Odoo's PostgreSQL-based backend architecture.

## Functional process 
This table supports the financial accounting reconciliation process. It tracks the matching of journal items (ledger entries) to ensure that debits and credits are fully settled, specifically handling exchange rate differences through the `exchange_move_id` reference.

## Description
One row in this table represents a single full reconciliation event between multiple accounting journal items. It serves as a raw landed copy in the staging layer, capturing the audit trail of who created or modified the reconciliation record and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_full_reconcile_id_seq`. |
| exchange_move_id | INTEGER | true | Reference to the journal entry for exchange rate difference | Links to the accounting move that accounts for currency fluctuations. |
| create_uid | INTEGER | true | User ID who created the record | References the user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the user table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `exchange_move_id` → `account_move.id` (Likely links to the journal entry table).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not appear to implement soft deletes; it represents the state of reconciliation records as they exist in the source.
- The `exchange_move_id` is nullable, implying that not all reconciliations result in an exchange rate adjustment entry.
- Ensure joins to `res_users` or `account_move` account for the possibility of missing records if the source system has undergone data purging.