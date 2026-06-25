# mrp_routing_workcenter_product_template_attribute_value_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the naming convention `mrp_routing_workcenter_..._rel`, which is characteristic of Odoo's many-to-many relationship join tables used to link manufacturing routing workcenters with product attribute configurations.

## Functional process 
This table supports the Manufacturing Resource Planning (MRP) process by defining the relationship between specific manufacturing workcenters and product attribute values. It allows the system to restrict or assign specific routing steps or workcenters based on the variant attributes of a product template.

## Description
One row in this table represents a single association between a manufacturing routing workcenter and a specific product template attribute value. It serves as a raw, junction-table copy from the source system, facilitating the many-to-many mapping required for complex product routing logic in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_routing_workcenter_id | INTEGER | false | Foreign key to the routing workcenter | Links to the primary workcenter definition. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Links to the specific attribute value configuration. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both columns `(mrp_routing_workcenter_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `mrp_routing_workcenter_id` → `mrp_routing_workcenter.id` (Inferred from Odoo naming patterns).
    - `product_template_attribute_value_id` → `product_template_attribute_value.id` (Inferred from Odoo naming patterns).
- **Natural keys (inferred):** The combination of `mrp_routing_workcenter_id` and `product_template_attribute_value_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes, only identifiers.
- There is no surrogate primary key; queries should use the composite key for joins or deduplication.
- As a staging table, this data is likely a direct dump from the source; ensure referential integrity is validated against the parent tables before performing heavy joins.