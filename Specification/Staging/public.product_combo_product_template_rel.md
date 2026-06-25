# product_combo_product_template_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular e-commerce/inventory management system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables between two entities, in this case, product templates and product combos.

## Functional process 
This table supports the product configuration and bundling process. It maps individual product templates to specific product combos, allowing the system to define which items are included in a bundled product offering or a promotional combo set.

## Description
One row in this table represents a single association between a product template and a product combo. It serves as a raw junction table in the staging layer, facilitating the many-to-many relationship required to build product bundles or kits.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template definition. | Represents the individual product component. |
| product_combo_id | INTEGER | false | Foreign key to the product combo definition. | Represents the parent bundle or combo container. |

## Keys

- **Primary key (inferred):** The composite of (`product_template_id`, `product_combo_id`).
- **Foreign keys (inferred):** 
    - `product_template_id` → `product_template.id` (Inferred from standard Odoo naming conventions).
    - `product_combo_id` → `product_combo.id` (Inferred from standard Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on the source system's full-refresh or log-based capture.
- Ensure joins to parent tables handle the potential for orphaned records if referential integrity is not strictly enforced in the source system.