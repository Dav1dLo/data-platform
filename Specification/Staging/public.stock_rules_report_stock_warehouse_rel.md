# stock_rules_report_stock_warehouse_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link report configurations to warehouse entities.

## Functional process 
This table supports the inventory reporting process by defining the many-to-many relationship between stock rule reports and specific warehouses. It allows the system to filter or aggregate stock rule data based on the scope of selected warehouses.

## Description
One row in this table represents a single association between a stock rules report and a warehouse. It acts as a join table in the staging layer, maintaining the link between reporting configurations and physical or logical warehouse locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_rules_report_id | INTEGER | false | Foreign key to the stock rules report definition. | Links to the parent report entity. |
| stock_warehouse_id | INTEGER | false | Foreign key to the warehouse entity. | Identifies the warehouse included in the report. |

## Keys

- **Primary key (inferred):** The combination of `stock_rules_report_id` and `stock_warehouse_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `stock_rules_report_id` → `stock_rules_report.id` (guessed based on naming convention).
    - `stock_warehouse_id` → `stock_warehouse.id` (guessed based on naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against both the report and warehouse dimension tables to retrieve meaningful attributes.
- There are no timestamps or audit columns present in this table.
- The table does not contain soft-delete flags; assume all records are active associations.