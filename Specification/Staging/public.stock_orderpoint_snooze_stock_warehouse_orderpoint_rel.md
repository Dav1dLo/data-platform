# stock_orderpoint_snooze_stock_warehouse_orderpoint_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `stock_orderpoint_snooze` and `stock_warehouse_orderpoint` is characteristic of Odoo's automated many-to-many relationship tables generated for ORM models.

## Functional process 
This table supports the inventory replenishment process by managing the relationship between snooze configurations and warehouse order points. It allows the system to track which specific "snooze" or "pause" settings are currently applied to individual stock replenishment rules (order points) to prevent unnecessary reordering.

## Description
One row in this table represents a single association between a snooze configuration and a warehouse order point. It serves as a raw landing junction table in the staging layer, facilitating the many-to-many relationship required to link replenishment suppression rules to specific stock locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_orderpoint_snooze_id | INTEGER | false | Foreign key to the snooze configuration entity | Part of the composite primary key. |
| stock_warehouse_orderpoint_id | INTEGER | false | Foreign key to the warehouse order point entity | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(stock_orderpoint_snooze_id, stock_warehouse_orderpoint_id)`
- **Foreign keys (inferred):** 
    - `stock_orderpoint_snooze_id → stock_orderpoint_snooze.id`: This column references the parent snooze configuration record.
    - `stock_warehouse_orderpoint_id → stock_warehouse_orderpoint.id`: This column references the specific replenishment rule (order point) being snoozed.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against the two referenced entities to retrieve meaningful business attributes.
- There are no timestamps or soft-delete flags present; this table represents the current state of associations as captured from the source system.
- Ensure that joins are handled carefully to avoid Cartesian products, as this table is purely relational.