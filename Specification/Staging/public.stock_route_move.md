# stock_route_move

## Source system
The source system is likely an ERP or Warehouse Management System (WMS) such as Odoo or a similar modular business application. The naming convention `stock_route_move` strongly suggests an association with inventory management modules where stock movements are linked to specific routing configurations.

## Functional process 
This table supports the inventory logistics and supply chain management process. It acts as a junction table to define the relationship between specific stock movement events and the predefined routing paths that dictate how goods flow through a facility or supply network.

## Description
One row in this table represents a single association between a stock movement and a routing definition. It serves as a raw landing copy of a many-to-many relationship table, used to maintain referential integrity between movement logs and route configurations in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| move_id | INTEGER | false | Unique identifier for the stock movement | Foreign key to the stock_move table. |
| route_id | INTEGER | false | Unique identifier for the routing path | Foreign key to the stock_route table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`move_id`, `route_id`).
- **Foreign keys (inferred):** 
    - `move_id` → `stock_move.id`: This column references the primary identifier of a stock movement record.
    - `route_id` → `stock_route.id`: This column references the primary identifier of a defined stock route.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction/link table; it contains no descriptive attributes other than the identifiers for the two entities it connects.
- There are no timestamps or audit columns present; rely on the parent tables for temporal context.
- As a staging table, it is assumed to be a direct, un-transformed extract from the source system.