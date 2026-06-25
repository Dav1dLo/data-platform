# account_analytic_line_stock_move_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `stock_move` and `account_analytic_line` is characteristic of Odoo's many-to-many relationship tables used to link inventory movements to analytic accounting entries.

## Functional process 
This table supports the cost accounting and inventory valuation process. It maps individual stock movements (physical goods flow) to analytic lines (financial tracking/cost centers), allowing the business to attribute inventory costs or consumption to specific projects, departments, or analytic accounts.

## Description
One row in this table represents a single association between a stock movement and an analytic accounting line. It serves as a raw junction table in the staging layer, facilitating the many-to-many relationship required to reconcile physical inventory activity with financial analytic reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_move_id | INTEGER | false | Foreign key to the stock move record | Represents the physical inventory transaction. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic line record | Represents the financial analytic entry. |

## Keys

- **Primary key (inferred):** The composite of (`stock_move_id`, `account_analytic_line_id`).
- **Foreign keys (inferred):** 
    - `stock_move_id` → `stock_move.id`: Links to the inventory movement record.
    - `account_analytic_line_id` → `account_analytic_line.id`: Links to the analytic accounting entry.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many cardinality.
- There are no timestamps or audit columns present; rely on the parent tables for temporal context.
- Ensure inner joins are used when filtering for specific analytic accounts to avoid orphaned records if the source system performs hard deletes on parent entities.