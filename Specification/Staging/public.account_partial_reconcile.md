# account_partial_reconcile

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`account_partial_reconcile`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based primary key pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the financial accounting reconciliation process, specifically tracking partial matches between debit and credit journal items. It links specific ledger entries that have been partially cleared against one another, facilitating the calculation of remaining balances for accounts receivable and payable.

## Description
One row in this table represents a single partial reconciliation event between a debit journal entry and a credit journal entry. As a staging table, it provides a raw, landed copy of the reconciliation records from the source ERP, serving as the foundation for downstream financial reporting and aging analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_partial_reconcile_id_seq`. |
| debit_move_id | INTEGER | false | ID of the debit journal item | References `account_move_line`. |
| credit_move_id | INTEGER | false | ID of the credit journal item | References `account_move_line`. |
| full_reconcile_id | INTEGER | true | ID of the full reconciliation | Links to a full reconciliation if this partial match completed the process. |
| exchange_move_id | INTEGER | true | ID of the exchange rate move | Used for currency gain/loss adjustments. |
| debit_currency_id | INTEGER | true | Currency ID of the debit side | References `res_currency`. |
| credit_currency_id | INTEGER | true | Currency ID of the credit side | References `res_currency`. |
| company_id | INTEGER | true | Company identifier | References `res_company`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users`. |
| max_date | DATE | true | Latest date of the reconciled items | Used for aging calculations. |
| amount | NUMERIC | true | Reconciled amount | The base currency value matched. |
| debit_amount_currency | NUMERIC | true | Amount in debit currency | The foreign currency value of the debit side. |
| credit_amount_currency | NUMERIC | true | Amount in credit currency | The foreign currency value of the credit side. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `debit_move_id` → `account_move_line.id` (Required for identifying the debit ledger entry).
    - `credit_move_id` → `account_move_line.id` (Required for identifying the credit ledger entry).
    - `full_reconcile_id` → `account_full_reconcile.id` (Optional link to a completed reconciliation).
    - `company_id` → `res_company.id` (Links to the organizational entity).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** This is a staging table; it may contain multiple versions of a record if the source system performs updates, though Odoo typically uses `write_date` to track the latest state.
- **Currency:** `amount` is in the company's base currency, while `debit_amount_currency` and `credit_amount_currency` represent the transaction-specific currency values.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are active unless filtered by business logic in the source system.