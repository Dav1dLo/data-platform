# template_attribute_value_stock_move_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular e-commerce/inventory management system. The naming convention `_rel` combined with the association of `stock_move` and `template_attribute_value` is characteristic of a many-to-many join table used in Odoo's ORM to link product variant attributes to specific stock movement records.

## Functional process 
This table supports the inventory and product configuration process, specifically tracking which product attribute values (e.g., color, size, material) are associated with specific stock movements. It enables the system to maintain granular traceability of variant-specific inventory changes within the supply chain or warehouse management pipeline.

## Description
One row in this table represents a single association between a stock movement record and a specific product attribute value. It serves as a raw, junction-table copy in the staging layer, facilitating the reconstruction of complex product variant relationships during inventory reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| move_id | INTEGER | false | Foreign key to the stock movement record | Links to the primary stock movement table. |
| template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value definition | Identifies the specific variant attribute applied. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(move_id, template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `move_id` → `stock_move.id`: This column references the unique identifier of a stock movement event.
    - `template_attribute_value_id` → `product_template_attribute_value.id`: This column references the definition of a specific attribute value for a product template.
- **Natural keys (inferred):** The combination of `(move_id, template_attribute_value_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against both the `stock_move` and `product_template_attribute_value` tables to produce meaningful business insights.
- There are no timestamps or audit columns present; this table represents a static snapshot of the relationship at the time of ingestion.
- The table contains no surrogate primary key, so distinct operations or grouping by the composite key may be required for deduplication.