# account_analytic_account_mrp_production_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_analytic_account_mrp_production_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link analytic accounting dimensions to manufacturing production orders.

## Functional process 
This table supports the cost accounting and manufacturing integration process. It maps specific manufacturing production orders (`mrp_production`) to analytic accounts, allowing the business to track production costs, overheads, and variances against specific projects or cost centers defined in the analytic accounting module.

## Description
One row in this table represents a single association between an analytic account and a manufacturing production order. It serves as a raw junction table in the staging layer, enabling the resolution of many-to-many relationships between production activities and financial tracking entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the financial cost tracking entity. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing order | Links to the specific production run. |

## Keys

- **Primary key (inferred):** The composite of (`account_analytic_account_id`, `mrp_production_id`).
- **Foreign keys (inferred):**
    - `account_analytic_account_id` → `account_analytic_account.id`: This column references the primary key of the analytic account table.
    - `mrp_production_id` → `mrp_production.id`: This column references the primary key of the manufacturing production order table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it is a pure relationship mapping.
- Ensure that joins to the target tables handle potential orphans if the source system's referential integrity is not strictly enforced.