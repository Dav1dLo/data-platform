# mrp_bom_line_product_template_attribute_value_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mrp_bom_line_..._rel` is characteristic of Odoo's ORM, which uses `_rel` suffix tables to manage many-to-many relationships between Bill of Materials (BOM) lines and product attribute values.

## Functional process 
This table supports the manufacturing configuration process, specifically linking components within a Bill of Materials to specific product attribute values (e.g., color, size, or material variants). It ensures that when a specific product variant is requested in a manufacturing order, the correct BOM line components are associated with the chosen attributes.

## Description
One row in this table represents a single association between a Bill of Materials line item and a specific product template attribute value. It serves as a raw landing copy of a join table, facilitating the many-to-many relationship required to define variant-specific BOM components.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_bom_line_id | INTEGER | false | Foreign key to the BOM line definition | Links to the parent manufacturing component record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the attribute value definition | Identifies the specific product variant attribute applied to this BOM line. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both columns.
- **Foreign keys (inferred):** 
    - `mrp_bom_line_id` → `mrp_bom_line.id`: This column references the specific line item within a Bill of Materials.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the specific attribute value (e.g., "Blue", "XL") assigned to the product.
- **Natural keys (inferred):** The combination of `(mrp_bom_line_id, product_template_attribute_value_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes or timestamps.
- There are no soft-delete flags; records are typically created or destroyed by the Odoo ORM when the relationship is modified.
- Queries joining this table should expect a many-to-many relationship grain.
- Ensure that joins to the parent tables handle potential missing records if the source system has experienced referential integrity issues during extraction.