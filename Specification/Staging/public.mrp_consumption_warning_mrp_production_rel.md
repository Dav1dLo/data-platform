# mrp_consumption_warning_mrp_production_rel

## Source system
This table likely originates from an Odoo ERP system or a similar modular manufacturing execution system (MES). The naming convention `mrp_consumption_warning_mrp_production_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link Material Requirements Planning (MRP) consumption warnings to specific production orders.

## Functional process 
This table supports the manufacturing production monitoring process by linking specific consumption warnings to the production orders that triggered them. It facilitates the tracking of material shortages or discrepancies identified during the production lifecycle, ensuring that production managers can trace warnings back to the relevant manufacturing work orders.

## Description
One row in this table represents a single association between an MRP consumption warning and a production order. It serves as a raw landing junction table in the staging layer, enabling the resolution of a many-to-many relationship between warning events and production entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_consumption_warning_id | INTEGER | false | Foreign key to the consumption warning record | Links to the primary key of the warning event. |
| mrp_production_id | INTEGER | false | Foreign key to the production order record | Links to the primary key of the manufacturing order. |

## Keys

- **Primary key (inferred):** The composite of (`mrp_consumption_warning_id`, `mrp_production_id`).
- **Foreign keys (inferred):** 
    - `mrp_consumption_warning_id` → `mrp_consumption_warning.id` (Guessed based on standard Odoo naming conventions for relation tables).
    - `mrp_production_id` → `mrp_production.id` (Guessed based on standard Odoo naming conventions for relation tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; the temporal context of these relationships must be inferred from the parent tables.
- Ensure that joins to parent tables handle potential orphan records if the source system does not enforce strict referential integrity at the database level.