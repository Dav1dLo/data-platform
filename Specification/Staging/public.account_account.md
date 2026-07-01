# account_account

## Source system
This table originates from Odoo ERP. The naming convention (`account_account`), the use of `JSONB` for localized fields like `name`, and the presence of `create_uid`/`write_uid` audit columns are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the General Ledger and Chart of Accounts management process. It defines the structure of the financial accounts used for recording transactions, including attributes for reconciliation, currency constraints, and account classification (e.g., asset, liability, equity).

## Description
One row represents a single financial account within the organization's chart of accounts. This is a raw staging entity, capturing the full configuration of an account as defined in the source ERP, including its display name, operational status, and reconciliation settings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_account_id_seq`. |
| currency_id | INTEGER | true | Foreign key to currency | Links to the account's fixed currency. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| account_type | VARCHAR | false | Account classification | Defines the nature of the account (e.g., 'asset', 'liability'). |
| name | JSONB | false | Account name | Localized name stored as JSON. |
| code_store | JSONB | true | Account code | Often stores the chart of accounts code. |
| note | TEXT | true | Internal notes | Free-text description of the account. |
| deprecated | BOOLEAN | true | Deprecation flag | Indicates if the account is no longer in use. |
| reconcile | BOOLEAN | true | Reconciliation flag | Indicates if the account supports manual reconciliation. |
| non_trade | BOOLEAN | true | Non-trade flag | Indicates if the account is excluded from trade reporting. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Guess: standard Odoo pattern for currency links).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `code_store` (Assuming the account code is unique within the chart of accounts).

## Caveats for downstream consumers

- **Sensitive Data:** Contains internal notes and user IDs; ensure access control is applied to `create_uid` and `write_uid`.
- **Timestamps:** Assumed to be in UTC as per standard Odoo configuration.
- **Data Format:** `name` and `code_store` are `JSONB` types; downstream consumers must parse these fields to extract human-readable strings or codes.
- **Soft Deletes:** This table does not appear to use a `deleted_at` column; the `deprecated` boolean should be used to filter out inactive accounts.
- **Schema:** The table uses a sequence for the `id` column; ensure ingestion processes respect the `nextval` default.