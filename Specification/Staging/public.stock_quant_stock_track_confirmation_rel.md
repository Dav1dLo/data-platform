# stock_quant_stock_track_confirmation_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `stock_quant` (representing inventory quantities) and `stock_track_confirmation` (representing tracking or serial number confirmation events) is characteristic of Odoo's many-to-many relationship join tables.

## Functional process 
This table supports the inventory tracking and traceability process. It acts as a bridge between inventory quant records and tracking confirmation records, allowing the system to associate specific stock quantities with tracking or serial number validation events in the warehouse management module.

## Description
One row in this table represents a single association between a specific inventory quantity record and a tracking confirmation record. It is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the link between these two entities within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_track_confirmation_id | INTEGER | false | Foreign key to the stock tracking confirmation record | Links to the parent confirmation event. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record | Links to the specific inventory quantity/location record. |

## Keys

- **Primary key (inferred):** The combination of (`stock_track_confirmation_id`, `stock_quant_id`).
- **Foreign keys (inferred):** 
    - `stock_track_confirmation_id` → `stock_track_confirmation.id` (Inferred from naming convention).
    - `stock_quant_id` → `stock_quant.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this table with both `stock_track_confirmation` and `stock_quant` to retrieve meaningful business data.
- There are no timestamps or audit columns present; the temporal context of when these associations were created must be derived from the parent tables.
- As a staging table, this data reflects the raw state of the source system's relational mapping and may contain orphaned records if referential integrity is not strictly enforced at the source.