# pos_category_product_template_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `product_template_id` and `pos_category_id` is characteristic of Odoo's many-to-many relational link tables used to map products to Point of Sale (POS) categories.

## Functional process 
This table supports the Point of Sale configuration process. It defines the many-to-many relationship between product templates and POS categories, determining which products are available or categorized under specific POS menu structures.

## Description
One row in this table represents a single association between a product template and a POS category. It serves as a raw landing of the join table from the source ERP, used to resolve the hierarchy of products within the POS interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template | Links to the master product definition. |
| pos_category_id | INTEGER | false | Foreign key to the POS category | Links to the POS category hierarchy. |

## Keys

- **Primary key (inferred):** The composite of (`product_template_id`, `pos_category_id`).
- **Foreign keys (inferred):**
    - `product_template_id` → `product_template.id`: This column references the primary product definition table.
    - `pos_category_id` → `pos_category.id`: This column references the POS category definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with both the `product_template` and `pos_category` tables to retrieve human-readable names.
- There are no timestamps or audit columns; it is impossible to determine the history of these associations from this table alone.
- This table contains no PII or sensitive financial data.