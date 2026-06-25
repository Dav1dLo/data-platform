# account_analytic_account_mrp_workcenter_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `account_analytic_account_mrp_workcenter_rel` follows the standard Odoo pattern for a many-to-many join table linking analytic accounts (used for cost accounting) to manufacturing work centers.

## Functional process 
This table supports the cost allocation process within the manufacturing module. It establishes a relationship between specific analytic accounts and manufacturing work centers, allowing costs incurred at a work center to be tracked against designated analytic accounts for financial reporting and project costing.

## Description
One row in this table represents a single association between an analytic account and a manufacturing work center. It serves as a raw landing copy of a many-to-many relationship table, facilitating the mapping required to attribute manufacturing overhead or operational costs to specific analytic dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_analytic_account_id | INTEGER | false | Foreign key to the analytic account | Links to the primary key of the analytic account table. |
| mrp_workcenter_id | INTEGER | false | Foreign key to the manufacturing work center | Links to the primary key of the mrp_workcenter table. |

## Keys

- **Primary key (inferred):** The combination of `account_analytic_account_id` and `mrp_workcenter_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `account_analytic_account_id` → `account_analytic_account.id`: This column references the analytic account entity.
    - `mrp_workcenter_id` → `mrp_workcenter.id`: This column references the manufacturing work center entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table.
- As a staging table, it reflects the raw state of the relationship; ensure that referential integrity is validated against the parent tables before joining.