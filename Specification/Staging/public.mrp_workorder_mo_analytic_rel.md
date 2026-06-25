# mrp_workorder_mo_analytic_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `mrp_workorder` (Manufacturing Resource Planning) and `account_analytic_line` (Financial/Analytic accounting). The `_rel` suffix is a standard Odoo pattern for many-to-many join tables.

## Functional process 
This table supports the integration between manufacturing operations and financial cost tracking. It links specific manufacturing work orders to their corresponding analytic accounting lines, allowing the business to track the costs (labor, machine time, etc.) incurred during the production process against specific analytic accounts or projects.

## Description
One row in this table represents a single association between a manufacturing work order and an analytic accounting line. It serves as a raw junction table in the staging layer, enabling the mapping of production activities to financial records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workorder_id | INTEGER | false | Foreign key to the manufacturing work order | Links to the production operation record. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic accounting line | Links to the financial cost/revenue record. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This is likely a composite primary key consisting of both `mrp_workorder_id` and `account_analytic_line_id`.
- **Foreign keys (inferred):** 
    - `mrp_workorder_id` → `mrp_workorder.id`: Links to the specific work order performed in the manufacturing module.
    - `account_analytic_line_id` → `account_analytic_line.id`: Links to the specific financial entry in the analytic accounting module.
- **Natural keys (inferred):** The combination of `(mrp_workorder_id, account_analytic_line_id)` acts as the natural key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no other descriptive attributes.
- Ensure inner joins are used if you only want records where both the work order and the analytic line exist.
- There is no audit timestamp (e.g., `created_at`) available in this table to determine when the relationship was established.