# mrp_account_wip_accounting

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_account_wip_accounting` (Manufacturing Resource Planning accounting module), the use of `create_uid`/`write_uid` audit columns, and the reliance on `nextval` sequences for primary keys, which are standard patterns in Odoo's PostgreSQL backend.

## Functional process 
This table supports the manufacturing accounting process, specifically tracking Work-in-Progress (WIP) journal entries. It links manufacturing activities to the general ledger by recording accounting references and dates associated with WIP adjustments or reversals.

## Description
One row represents a single accounting entry or adjustment related to manufacturing WIP. It serves as a raw landed copy of the source system's WIP accounting ledger, capturing the temporal aspects of journal entries and their associated reversals.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_account_wip_accounting_id_seq`. |
| journal_id | INTEGER | false | Foreign key to the accounting journal | Identifies the specific ledger journal used for this entry. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the entry. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user who last updated the entry. |
| reference | VARCHAR | true | Transaction reference string | Often contains document numbers or internal codes. |
| date | DATE | true | Accounting date | The date the entry is effective in the ledger. |
| reversal_date | DATE | false | Scheduled reversal date | The date on which this accounting entry is set to be reversed. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp for ingestion. |
| write_date | TIMESTAMP | true | Last modification timestamp | Audit timestamp for ingestion. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id` (Guess: standard Odoo naming convention for journal links).
    - `create_uid` → `res_users.id` (Guess: standard Odoo naming convention for user audit trails).
    - `write_uid` → `res_users.id` (Guess: standard Odoo naming convention for user audit trails).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in the database's default timezone (typically UTC in Odoo environments).
- **Data Integrity:** `reversal_date` is mandatory, suggesting that every WIP accounting entry is expected to have a defined lifecycle or reversal point.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` or `active` flag; assume all rows are active unless otherwise specified by the source system logic.
- **Sensitivity:** `create_uid` and `write_uid` link to user tables; ensure access controls are in place if mapping these to specific employee identities.