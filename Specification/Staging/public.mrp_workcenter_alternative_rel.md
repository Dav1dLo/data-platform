# mrp_workcenter_alternative_rel

## Source system
This table likely originates from an Odoo ERP system, as the naming convention `mrp_workcenter_alternative_rel` is characteristic of Odoo's automated many-to-many relationship tables (often suffixed with `_rel`) within the Manufacturing Resource Planning (MRP) module.

## Functional process 
This table supports the manufacturing capacity planning process by defining alternative work centers. It allows the production system to route work orders to secondary or backup work centers if the primary work center is unavailable or at capacity.

## Description
One row in this table represents a single association between a primary work center and an authorized alternative work center. It is a raw landing of a join table used to resolve many-to-many relationships in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| workcenter_id | INTEGER | false | Foreign key to the primary work center | References the main production unit. |
| alternative_workcenter_id | INTEGER | false | Foreign key to the alternative work center | References the backup production unit. |

## Keys

- **Primary key (inferred):** The composite of (`workcenter_id`, `alternative_workcenter_id`).
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id`: This column identifies the primary work center in the manufacturing module.
    - `alternative_workcenter_id` → `mrp_workcenter.id`: This column identifies the backup work center available for substitution.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes or timestamps.
- There is no explicit soft-delete flag; assume that the absence of a record indicates the removal of the alternative relationship in the source system.
- Ensure that joins to the `mrp_workcenter` table handle the potential for circular references if the data is not strictly validated at the source.