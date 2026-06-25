# stock_wh_resupply_table

## Source system
The source system is unknown — insufficient evidence. The table name suggests an internal warehouse management or logistics system, but there are no standard vendor-specific prefixes or naming conventions (e.g., SAP, Oracle, or NetSuite) to confirm the origin.

## Functional process 
This table supports inventory replenishment and inter-warehouse stock transfer processes. It defines the relationship between a warehouse that receives stock (`supplied_wh_id`) and the warehouse that acts as the source or supplier for that stock (`supplier_wh_id`).

## Description
One row in this table represents a single resupply link or routing rule between two warehouse entities. As a staging table, it serves as a raw, landed representation of warehouse-to-warehouse supply chain dependencies, likely used to map replenishment paths for inventory balancing.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| supplied_wh_id | INTEGER | false | The unique identifier of the warehouse receiving the stock. | Acts as the destination node in the supply chain. |
| supplier_wh_id | INTEGER | false | The unique identifier of the warehouse providing the stock. | Acts as the source node in the supply chain. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`supplied_wh_id`, `supplier_wh_id`).
- **Foreign keys (inferred):** 
    - `supplied_wh_id` → `warehouses.id` (guess): This column likely references a master warehouse dimension table.
    - `supplier_wh_id` → `warehouses.id` (guess): This column likely references the same master warehouse dimension table.
- **Natural keys (inferred):** The combination of (`supplied_wh_id`, `supplier_wh_id`) is the business key representing a unique resupply route.

## Caveats for downstream consumers

- There are no timestamps or audit columns provided; it is unclear if this table represents a point-in-time snapshot or a current state.
- The table lacks a surrogate primary key, so queries should treat the combination of both columns as the unique identifier.
- As a staging table, verify if this data is intended to be a full-load or incremental-load; there is no metadata to indicate soft-delete handling.