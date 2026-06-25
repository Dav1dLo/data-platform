# stock_inventory_warning_stock_quant_rel

## Source system
The table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `stock_inventory_warning` and `stock_quant` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link inventory warning records to specific stock quant (quantity) records.

## Functional process 
This table supports the inventory management and replenishment process. It acts as a join table to associate specific inventory warning alerts with the underlying stock quant records that triggered or are relevant to those warnings, facilitating the tracking of stock levels against predefined thresholds.

## Description
One row in this table represents a single association between an inventory warning record and a stock quantity record. It serves as a raw landed link table in the staging layer, enabling the reconstruction of many-to-many relationships between inventory alerts and physical stock units.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_warning_id | INTEGER | false | Foreign key to the inventory warning record | Links to the parent warning entity. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record | Links to the specific stock quantity entity. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely uses a composite primary key consisting of both columns `(stock_inventory_warning_id, stock_quant_id)`.
- **Foreign keys (inferred):** 
    - `stock_inventory_warning_id` → `stock_inventory_warning.id`: This column references the primary identifier of the inventory warning table.
    - `stock_quant_id` → `stock_quant.id`: This column references the primary identifier of the stock quant table.
- **Natural keys (inferred):** The combination of `(stock_inventory_warning_id, stock_quant_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; rely on the parent tables for temporal context.
- Ensure inner joins are used when querying to maintain referential integrity, as this table does not contain its own business logic.