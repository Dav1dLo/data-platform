# account_accrued_orders_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on `id`). The "wizard" suffix is characteristic of Odoo's transient models used to facilitate user-driven business processes.

## Functional process 
This table supports the "Accrued Orders" financial process, specifically acting as a transient wizard to facilitate the creation of accrual journal entries. It captures the parameters required to generate accounting adjustments for orders that have been fulfilled but not yet invoiced, linking specific accounts, journals, and currencies to a target date and reversal date.

## Description
One row in this table represents a single configuration instance of an accrued orders generation task initiated by a user. It serves as a staging record for the parameters (dates, amounts, and accounting dimensions) required to trigger the automated creation of journal entries. This is a raw landed copy of the wizard's state at the time of execution.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the legal entity. |
| journal_id | INTEGER | false | Foreign key to the accounting journal | The journal where the entry will be posted. |
| currency_id | INTEGER | true | Foreign key to the currency | The transaction currency. |
| account_id | INTEGER | false | Foreign key to the general ledger account | The account to be accrued. |
| create_uid | INTEGER | true | User ID who created the record | References the system user. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user. |
| date | DATE | false | Accrual date | The effective date for the accrual entry. |
| reversal_date | DATE | false | Reversal date | The date the accrual is expected to reverse. |
| amount | NUMERIC | true | Accrual amount | The monetary value of the accrual. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo company reference)
    - `journal_id` → `account_journal.id` (Guess: standard Odoo journal reference)
    - `currency_id` → `res_currency.id` (Guess: standard Odoo currency reference)
    - `account_id` → `account_account.id` (Guess: standard Odoo chart of accounts reference)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user tables; ensure access to user metadata is restricted if PII is present in the source user system.
- **Transient Nature:** As a "wizard" table, this data may be ephemeral or intended for short-term storage; verify if the source system truncates or purges these records periodically.
- **Nullability:** Several fields (like `amount` and `company_id`) are nullable, which may indicate incomplete wizard configurations or default system behavior.