# account_account

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `account_account` and the presence of `create_uid`, `write_uid`, and `JSONB` fields for multi-language support are characteristic of the Odoo ORM's database schema.

## Functional process 
This table supports the General Ledger and Chart of Accounts management process. It defines the structure of the financial accounts used for recording transactions, including account types, reconciliation settings, and multi-currency configurations.

## Description
One row in this table represents a single financial account within the organization's chart of accounts. It serves as a raw landing copy of the Odoo `account.account` model, capturing the configuration, metadata, and audit trails for each account record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_account_id_seq` sequence. |
| currency_id | INTEGER | true | Foreign key to currency | Links to the account's specific currency. |
| create_uid | INTEGER | true | Creator user ID | Links to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Links to the user who last updated the record. |
| account_type | VARCHAR | false | Account classification | Defines the nature of the account (e.g., asset, liability). |
| name | JSONB | false | Account name | Localized name stored as JSON. |
| code_store | JSONB | true | Account code | Internal accounting code, stored as JSON. |
| note | TEXT | true | Descriptive notes | Free-text field for account details. |
| deprecated | BOOLEAN | true | Deprecation flag | Indicates if the account is no longer in use. |
| reconcile | BOOLEAN | true | Reconciliation flag | Indicates if the account supports reconciliation. |
| non_trade | BOOLEAN | true | Non-trade flag | Indicates if the account is excluded from trade reporting. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Guess: standard Odoo pattern for currency links).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail pattern).
- **Natural keys (inferred):** 
    - `code_store` (In many Odoo implementations, the account code is the unique business identifier).

## Caveats for downstream consumers

- **Data Types:** `name` and `code_store` are `JSONB` fields; ensure your downstream transformation logic handles JSON extraction (e.g., `name->>'en_US'`).
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to use a `deleted_at` column; check the `deprecated` boolean to filter out inactive accounts.
- **Sensitivity:** No direct PII is present, but `create_uid` and `write_uid` link to internal user identities.