# mrp_account_wip_accounting_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_account_wip_accounting_line`), the use of `create_uid`/`write_uid` for audit tracking, and the sequence-based primary key pattern common in Odoo's PostgreSQL backend.

## Functional process 
This table supports the manufacturing accounting process, specifically tracking Work-in-Progress (WIP) accounting entries. It records the individual line items associated with WIP accounting movements, capturing the financial impact (debit/credit) of manufacturing operations on specific accounts.

## Description
One row represents a single accounting line entry associated with a WIP accounting record. It serves as a raw landed staging entity, capturing the financial details of manufacturing WIP adjustments at the grain of an individual ledger line.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| account_id | INTEGER | true | Foreign key to the general ledger account | Links to the chart of accounts. |
| currency_id | INTEGER | true | Foreign key to the currency table | Defines the currency of the transaction. |
| wip_accounting_id | INTEGER | true | Foreign key to the parent WIP accounting record | Links this line to its parent header. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| label | VARCHAR | true | Descriptive label for the accounting entry | Often contains a memo or transaction description. |
| debit | NUMERIC | true | Debit amount | Financial value in the transaction currency. |
| credit | NUMERIC | true | Credit amount | Financial value in the transaction currency. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed based on standard Odoo patterns. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed based on standard Odoo patterns. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account.id` (Guess: standard Odoo accounting schema).
    - `currency_id` → `res_currency.id` (Guess: standard Odoo multi-currency schema).
    - `wip_accounting_id` → `mrp_account_wip_accounting.id` (Guess: parent header table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains financial transaction data; ensure access is restricted to authorized finance/accounting roles.
- **Timestamps:** Assumed to be in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted or archived by the source system.
- **Data Integrity:** As a staging table, it may contain duplicates or partial loads if the ingestion process is interrupted; verify row counts against the source system.