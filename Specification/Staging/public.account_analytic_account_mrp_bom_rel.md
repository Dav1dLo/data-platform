# account_analytic_account_mrp_bom_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `account_analytic_account_mrp_bom_rel`. The `_rel` suffix and the combination of analytic accounts and manufacturing bill of materials (BOM) are characteristic of Odoo's many-to-many relationship join tables.

## Functional process 
This table supports the integration between financial cost tracking and manufacturing operations. It links analytic accounts (used for cost center tracking and project accounting) to specific Bills of Materials (BOMs), allowing the system to associate manufacturing costs or production activities with specific analytic projects or departments.

## Description
This table is a join entity representing a many-to-many relationship between analytic accounts and manufacturing bills of materials. Each row represents a single association between one analytic account and one BOM. It serves as a raw landing copy of the relational mapping used within the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the primary key of the analytic account table. |
| mrp_bom_id | INTEGER | false | Foreign key to the manufacturing BOM | Links to the primary key of the mrp_bom table. |

## Keys

- **Primary key (inferred):** The composite of `(account_analytic_account_id, mrp_bom_id)`.
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `account_analytic_account.id`: This column references the analytic account entity used for cost tracking.
    - `mrp_bom_id` → `mrp_bom.id`: This column references the manufacturing bill of materials definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with both the `account_analytic_account` and `mrp_bom` tables to retrieve meaningful business attributes.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification history of these relationships from this table alone.
- This table does not contain soft-delete flags; assume that the absence of a record indicates the relationship does not exist.