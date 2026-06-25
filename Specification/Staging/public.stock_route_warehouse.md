# stock_route_warehouse

## Source system
Unknown — insufficient evidence. The table name suggests a mapping between logistics routes and warehouse facilities, but the lack of prefixing or specific naming conventions (like `sap_` or `netsuite_`) makes it impossible to attribute to a specific ERP or WMS system.

## Functional process 
This table supports logistics and supply chain network configuration. It defines the many-to-many relationship between distribution routes and the warehouses that service or participate in those routes, likely used to determine inventory sourcing or delivery pathing.

## Description
One row in this table represents a single association between a specific route and a specific warehouse. It serves as a raw landing of a junction table, capturing the structural link between route entities and warehouse entities within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Unique identifier for the route | Foreign key to a routes dimension. |
| warehouse_id | INTEGER | false | Unique identifier for the warehouse | Foreign key to a warehouses dimension. |

## Keys

- **Primary key (inferred):** (`route_id`, `warehouse_id`)
- **Foreign keys (inferred):** 
    - `route_id` → `routes.id` (Inferred based on naming convention).
    - `warehouse_id` → `warehouses.id` (Inferred based on naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect duplicate IDs in individual columns, but the pair should be unique.
- No audit timestamps (e.g., `created_at`) are present, so incremental loading logic cannot rely on row-level metadata.
- There are no soft-delete flags; assume this table represents the current state of associations as extracted from the source.