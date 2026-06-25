# mrp_production_picking_label_type_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `mrp_production_picking_label_type_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link Manufacturing Resource Planning (MRP) production orders to specific picking label configurations.

## Functional process 
This table supports the manufacturing execution and logistics process by mapping production orders to specific label types required for picking operations. It ensures that when a production order is processed, the system knows which label format or type should be generated for the associated inventory picking tasks.

## Description
One row in this table represents a single association between a manufacturing production order and a picking label type. This is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the link between these two entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| picking_label_type_id | INTEGER | false | Foreign key to the picking label type definition. | Links to the configuration entity. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order. | Links to the core production entity. |

## Keys

- **Primary key (inferred):** The combination of `(mrp_production_id, picking_label_type_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `picking_label_type_id` → `picking_label_type.id` (guess: standard Odoo naming convention for related entities).
    - `mrp_production_id` → `mrp_production.id` (guess: standard Odoo naming convention for related entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on the upstream source system's change tracking if available.
- Ensure joins to the target tables handle potential orphans if referential integrity is not strictly enforced at the database level in the source system.