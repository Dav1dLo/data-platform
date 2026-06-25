# product_template_attribute_value_sale_order_line_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association between `sale_order_line` and `product_template_attribute_value` is characteristic of Odoo's many-to-many relationship tables used to track variant attributes selected on specific sales order lines.

## Functional process 
This table supports the sales order management process by linking specific product variant attributes (such as color, size, or material) to individual line items on a sales order. It ensures that when a customer selects a specific configuration of a product, the system tracks which attribute values were chosen for that specific line item.

## Description
One row in this table represents a single association between a sales order line and a specific product attribute value. It serves as a raw junction table in the staging layer, facilitating the resolution of many-to-many relationships between order line items and product configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sales order line | Links to the specific line item in the order. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific attribute value (e.g., "Blue") selected. |

## Keys

- **Primary key (inferred):** The combination of `(sale_order_line_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `sale_order_line.id`: This column references the primary key of the sales order line table.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the primary key of the product attribute value definition table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive data other than the two foreign keys.
- Expect high cardinality on both columns as orders accumulate over time.
- There is no audit timestamp or soft-delete flag present; this table represents the current state of associations as landed from the source.
- Ensure joins are performed on both columns to avoid Cartesian products when querying.