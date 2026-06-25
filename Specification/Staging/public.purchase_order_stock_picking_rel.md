# purchase_order_stock_picking_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables between two core entities: purchase orders and stock pickings (inventory movements).

## Functional process 
This table supports the procurement and inventory management process, specifically linking purchase orders to the resulting warehouse stock movements. It tracks the association between a procurement request (purchase order) and the physical fulfillment or receipt of goods (stock picking).

## Description
One row in this table represents a single association between a specific purchase order and a specific stock picking event. It serves as a raw junction table in the staging layer, enabling the resolution of many-to-many relationships between procurement and logistics entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_id | INTEGER | false | Foreign key to the purchase order entity | Represents the procurement document identifier. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking entity | Represents the inventory movement identifier. |

## Keys

- **Primary key (inferred):** The composite of (`purchase_order_id`, `stock_picking_id`).
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `purchase_order.id` (Inferred from standard ERP naming conventions).
    - `stock_picking_id` → `stock_picking.id` (Inferred from standard ERP naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on the upstream source system's change tracking if available.
- Ensure joins are performed on both columns to maintain the integrity of the relationship, as neither column is unique on its own.