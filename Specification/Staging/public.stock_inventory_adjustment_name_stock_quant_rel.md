# stock_inventory_adjustment_name_stock_quant_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific prefix `stock_inventory_adjustment_name` and `stock_quant` is characteristic of Odoo's many-to-many relational join tables used to link inventory adjustments to specific stock quantities.

## Functional process 
This table supports the inventory management and reconciliation process. It acts as a bridge between inventory adjustment records (which track the intent to change stock levels) and the specific stock quant records (which track the actual physical or virtual stock levels in a specific location).

## Description
One row in this table represents a single association between an inventory adjustment event and a specific stock quantity record. It is a raw landing copy of a join table, serving to resolve the many-to-many relationship between inventory adjustments and stock quants within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_adjustment_name_id | INTEGER | false | Foreign key to the inventory adjustment record | Links to the parent adjustment event. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record | Links to the specific stock quantity being adjusted. |

## Keys

- **Primary key (inferred):** The composite of `(stock_inventory_adjustment_name_id, stock_quant_id)`.
- **Foreign keys (inferred):** 
    - `stock_inventory_adjustment_name_id` → `stock_inventory_adjustment_name.id`: Evidence is the naming convention matching a parent entity.
    - `stock_quant_id` → `stock_quant.id`: Evidence is the naming convention matching a parent entity.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There is no surrogate primary key column; queries should rely on the composite key for uniqueness.
- As a staging table, it may contain orphaned records if the upstream source system does not enforce strict referential integrity during the landing process.