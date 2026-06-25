# product_attribute_product_template_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular e-commerce/inventory management system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (join tables) between product attributes and product templates.

## Functional process 
This table supports the product catalog management process, specifically the configuration of product variants. It maps which attributes (e.g., "Color", "Size") are applicable to specific product templates (e.g., "T-Shirt"), enabling the system to generate the correct combinations of variants for a product.

## Description
One row in this table represents a single association between a product attribute and a product template. It serves as a raw, junction-table copy from the source system, facilitating the many-to-many relationship required to define product variant structures.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_attribute_id | INTEGER | false | Foreign key to the product attribute definition. | Identifies the specific attribute being linked. |
| product_template_id | INTEGER | false | Foreign key to the product template definition. | Identifies the specific product template being configured. |

## Keys

- **Primary key (inferred):** The composite of (`product_attribute_id`, `product_template_id`).
- **Foreign keys (inferred):** 
    - `product_attribute_id` → `product_attribute.id`: This column links to the master list of available product attributes.
    - `product_template_id` → `product_template.id`: This column links to the master list of product templates.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes or timestamps.
- As a staging table, it may contain orphaned records if the source system does not enforce strict referential integrity at the database level.
- Queries should perform `INNER JOIN` operations against the respective master tables to retrieve meaningful business names for the attributes or templates.