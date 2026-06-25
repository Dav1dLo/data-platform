# product_variant_combination

## Source system
The table likely originates from an Odoo ERP system, as indicated by the naming convention `product_template_attribute_value_id`, which is a standard identifier pattern used in Odoo's product configuration and variant management modules.

## Functional process 
This table supports the product catalog and inventory management process by defining the relationship between specific product variants and the attribute values that compose them (e.g., linking a specific "Blue, Size M" variant to its constituent attribute IDs). It acts as a bridge table to resolve complex product configurations.

## Description
One row in this table represents a single association between a product variant and a specific attribute value. It serves as a raw landing copy of the join table used to map product variants to their defining characteristics within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_product_id | INTEGER | false | Foreign key to the product variant | Represents the specific variant ID. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the attribute value | Represents the specific attribute option (e.g., color or size). |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(product_product_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `product_product_id` → `product.id` (Guess: links to the main product variant table).
    - `product_template_attribute_value_id` → `product_attribute_value.id` (Guess: links to the definition of the attribute value).
- **Natural keys (inferred):** The combination of `product_product_id` and `product_template_attribute_value_id` acts as the business key for this mapping.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between products and attribute values.
- No audit timestamps (e.g., `created_at`) are present, so incremental loading logic cannot rely on standard watermarks.
- The table contains no soft-delete flags; assume it represents the current state of the source system's mapping.