# account_journal

## Source system
This table originates from an Odoo ERP system. The naming conventions (e.g., `create_uid`, `write_uid`, `company_id`, `JSONB` for translatable fields) and the specific functional domain of "journals" are characteristic of the Odoo accounting module's database schema.

## Functional process 
This table supports the core accounting and financial reporting process by defining the journals used to record financial transactions. It manages the configuration of various journal types (e.g., bank, cash, sales, purchase) and their associated ledger accounts, sequence numbering, and posting behaviors.

## Description
One row in this table represents a single accounting journal configuration within a specific company. It acts as a staging entity, providing a raw, direct copy of the journal settings used to categorize and process financial entries. The grain is one row per journal definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_journal_id_seq`. |
| alias_id | INTEGER | true | Linked email alias ID | Used for incoming mail integration. |
| default_account_id | INTEGER | true | Default GL account | The primary account for this journal. |
| suspense_account_id | INTEGER | true | Suspense GL account | Used for temporary transaction holding. |
| sequence | INTEGER | true | Sequence ID | Links to the sequence generator. |
| currency_id | INTEGER | true | Currency ID | The currency associated with this journal. |
| company_id | INTEGER | false | Company ID | Foreign key to the owning company. |
| profit_account_id | INTEGER | true | Profit GL account | Used for exchange rate gains. |
| loss_account_id | INTEGER | true | Loss GL account | Used for exchange rate losses. |
| bank_account_id | INTEGER | true | Bank account ID | Links to the specific bank account record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| color | INTEGER | true | UI color index | Used for dashboard visualization. |
| access_token | INTEGER | true | Security token | Used for external access/API. |
| code | VARCHAR(5) | false | Journal code | Short alphanumeric identifier (e.g., 'BNK1'). |
| type | VARCHAR | false | Journal type | Category (e.g., 'sale', 'purchase', 'bank'). |
| invoice_reference_type | VARCHAR | false | Invoice ref type | Logic for generating invoice references. |
| invoice_reference_model | VARCHAR | false | Invoice ref model | The model used for reference generation. |
| bank_statements_source | VARCHAR | true | Bank feed source | Source of bank statement imports. |
| name | JSONB | false | Journal name | Multilingual name stored as JSON. |
| sequence_override_regex | TEXT | true | Regex for sequence | Pattern to override default sequencing. |
| active | BOOLEAN | true | Soft delete flag | If false, the journal is archived. |
| autocheck_on_post | BOOLEAN | true | Post validation flag | Whether to check entries upon posting. |
| restrict_mode_hash_table | BOOLEAN | true | Hash restriction | Enables immutable ledger mode. |
| refund_sequence | BOOLEAN | true | Refund sequence flag | Whether to use a separate refund sequence. |
| payment_sequence | BOOLEAN | true | Payment sequence flag | Whether to use a separate payment sequence. |
| show_on_dashboard | BOOLEAN | true | Dashboard visibility | Whether to display on the accounting dashboard. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `currency_id` → `res_currency.id` (Standard Odoo currency reference).
    - `default_account_id` → `account_account.id` (Links to the Chart of Accounts).
- **Natural keys (inferred):** 
    - `code` (within the scope of `company_id`)

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` should be treated as a secret and excluded from general reporting.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical/archived data is required.
- **JSONB:** The `name` column is a `JSONB` object; use `name->>'en_US'` or similar syntax to extract specific language values.