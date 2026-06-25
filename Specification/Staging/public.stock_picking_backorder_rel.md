# stock_picking_backorder_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables, and the column names `stock_backorder_confirmation_id` and `stock_picking_id` align with Odoo's inventory management module (Stock) schema.

## Functional process 
This table supports the inventory management process, specifically the handling of backorders. It acts as a join table to link backorder confirmation events to the specific stock picking operations that were split or backordered, ensuring traceability between the original picking request and the resulting backorder records.

## Description
One row in this table represents a single association between a backorder confirmation record and a stock picking record. This is a raw landing table in the staging layer, serving as a bridge to resolve the many-to-many relationship between backorder confirmations and stock pickings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_backorder_confirmation_id | INTEGER | false | Foreign key to the backorder confirmation record | Part of the composite primary key. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(stock_backorder_confirmation_id, stock_picking_id)`
- **Foreign keys (inferred):** 
    - `stock_backorder_confirmation_id` → `stock_backorder_confirmation.id` (Inferred from Odoo naming conventions).
    - `stock_picking_id` → `stock_picking.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no business attributes, only identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent tables for creation or modification context.
- As a staging table, this may contain orphaned records if the upstream system does not enforce strict referential integrity during the landing process.