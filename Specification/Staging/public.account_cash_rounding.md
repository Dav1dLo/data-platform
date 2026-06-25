# account_cash_rounding

## Source system
This table originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `JSONB` for relational fields (likely representing Odoo's `Many2one` field structures), is characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the financial accounting and invoicing process, specifically managing how cash payments are rounded to the nearest currency unit. It defines the rounding strategies and associated profit/loss accounts used when a transaction total is adjusted for cash payment constraints.

## Description
One row represents a single cash rounding configuration rule defined within the accounting module. It specifies the mathematical strategy, the rounding precision, and the ledger accounts to which rounding differences should be posted. This is a raw landing of the configuration entity, intended for use in downstream financial reporting and invoice validation logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.account_cash_rounding_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the user table. |
| strategy | VARCHAR | false | Rounding strategy identifier | Defines the logic applied (e.g., 'add_invoice_line'). |
| rounding_method | VARCHAR | false | Method of rounding | Defines the direction (e.g., 'HALF-UP', 'UP', 'DOWN'). |
| name | JSONB | false | Display name of the rounding rule | Likely contains multi-language labels. |
| profit_account_id | JSONB | true | Profit account reference | JSON structure containing the ID and name of the gain account. |
| loss_account_id | JSONB | true | Loss account reference | JSON structure containing the ID and name of the loss account. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| rounding | DOUBLE PRECISION | false | Rounding precision value | The increment to which amounts are rounded. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Fields:** `name`, `profit_account_id`, and `loss_account_id` are stored as JSONB. You will need to use PostgreSQL `->>` operators or `jsonb_to_record` to extract specific values (e.g., `profit_account_id->>'id'`).
- **Timestamps:** All `_date` columns are assumed to be in UTC.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records present are currently active in the source system.
- **Precision:** The `rounding` column is a `DOUBLE PRECISION` float; be cautious of floating-point arithmetic errors when performing financial calculations.