# product_attribute_value_product_template_attribute_line_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `product_attribute_value` and `product_template_attribute_line` is characteristic of Odoo's many-to-many relationship tables used to link attribute values to specific product template lines.

## Functional process 
This table supports the product configuration and variant management process. It defines which specific attribute values (e.g., "Red", "Large") are associated with a product's attribute lines (e.g., "Color", "Size") within the product template definition.

## Description
One row in this table represents a single association between a product attribute value and a product template attribute line. It serves as a raw junction table in the staging layer, facilitating the many-to-many relationship required to build product variants.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_attribute_value_id | INTEGER | false | Foreign key to the attribute value definition. | Links to the specific value (e.g., 'Blue'). |
| product_template_attribute_line_id | INTEGER | false | Foreign key to the product template attribute line. | Links to the attribute category for a template. |

## Keys

- **Primary key (inferred):** The composite key of (`product_attribute_value_id`, `product_template_attribute_line_id`).
- **Foreign keys (inferred):** 
    - `product_attribute_value_id` → `product_attribute_value.id` (Inferred from Odoo naming conventions).
    - `product_template_attribute_line_id` → `product_template_attribute_line.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- Expect high cardinality relative to the parent tables.
- There are no timestamps or soft-delete flags present; this table represents the current state of the relationship as landed from the source.