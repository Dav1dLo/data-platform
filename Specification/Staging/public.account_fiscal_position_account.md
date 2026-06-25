# account_fiscal_position_account

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `account_fiscal_position_account`, `create_uid`, `write_uid`) is characteristic of Odoo's ORM-generated database schema, which manages fiscal mapping rules for accounting.

## Functional process 
This table supports the "Tax and Fiscal Mapping" process within the accounting module. It defines how specific general ledger accounts are remapped (e.g., from a source tax account to a destination tax account) based on the fiscal position applied to a transaction, ensuring compliance with regional tax regulations.

## Description
One row represents a single account mapping rule within a specific fiscal position. It acts as a raw landed copy of the Odoo configuration table, capturing the relationship between a source account and its destination account for tax or reporting adjustments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| position_id | INTEGER | false | Foreign key to fiscal position | Links to the parent fiscal position definition. |
| company_id | INTEGER | true | Company identifier | Multi-company context; null implies global scope. |
| account_src_id | INTEGER | false | Source account ID | The original account to be mapped. |
| account_dest_id | INTEGER | false | Destination account ID | The account to map to. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `position_id` → `account_fiscal_position.id`: This column links the mapping rule to its parent fiscal position configuration.
    - `account_src_id` → `account_account.id`: This column references the source general ledger account.
    - `account_dest_id` → `account_account.id`: This column references the target general ledger account.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo, but verify against your specific instance configuration.
- This table contains no PII, but it does contain internal system identifiers that should be joined against the corresponding master data tables to be meaningful.
- There is no explicit soft-delete flag; Odoo typically manages record lifecycle via `active` columns, which are absent here, suggesting this table tracks active mappings only.