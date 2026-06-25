# mrp_workorder_wc_analytic_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `mrp_workorder_` and `account_analytic_line_` is characteristic of Odoo's Manufacturing (MRP) and Accounting modules, where `_rel` tables are standard junction tables used to manage many-to-many relationships between manufacturing operations and financial analytic tracking.

## Functional process 
This table supports the integration between manufacturing execution and cost accounting. It links specific manufacturing work orders to analytic accounting lines, allowing the business to track the actual costs (labor, machine time, overhead) incurred during the production process against specific analytic accounts or projects.

## Description
One row in this table represents a single association between a manufacturing work order and an analytic accounting line. It serves as a raw junction table in the staging layer, enabling the mapping of production activities to financial cost centers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workorder_id | INTEGER | false | Foreign key to the manufacturing work order. | Links to the production operation record. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic accounting line. | Links to the financial cost/revenue record. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(mrp_workorder_id, account_analytic_line_id)`.
- **Foreign keys (inferred):** 
    - `mrp_workorder_id` → `mrp_workorder.id`: Links to the source manufacturing work order.
    - `account_analytic_line_id` → `account_analytic_line.id`: Links to the source financial analytic entry.
- **Natural keys (inferred):** The combination of `(mrp_workorder_id, account_analytic_line_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There is no surrogate primary key; queries should use the composite pair to ensure uniqueness.
- As a staging table, this data reflects the raw state of the Odoo database; verify if the source system performs hard deletes on these relationships, as junction records are often removed entirely when the link is severed in the UI.