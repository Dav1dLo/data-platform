# product_template_attribute_value_purchase_order_line_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` combined with the specific association of `product_template_attribute_value` and `purchase_order_line` is characteristic of Odoo's many-to-many relationship tables used to link purchase order line items to specific product variant attributes (e.g., color, size, or custom configuration).

## Functional process 
This table supports the procurement and inventory management process. It acts as a bridge to track which specific product attribute values were selected or configured for items included in a purchase order line, ensuring that the correct product variant is ordered from the supplier.

## Description
One row in this table represents a single association between a purchase order line and a specific product attribute value. It serves as a raw landing copy of a many-to-many join table, facilitating the reconstruction of complex product configurations within purchase orders.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_line_id | INTEGER | false | Foreign key to the purchase order line | Links to the specific line item in a purchase order. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value | Identifies the specific attribute value (e.g., "Size: XL") selected. |

## Keys

- **Primary key (inferred):** The combination of `purchase_order_line_id` and `product_template_attribute_value_id`.
- **Foreign keys (inferred):** 
    - `purchase_order_line_id` → `purchase_order_line.id` (Inferred from standard Odoo naming conventions for join tables).
    - `product_template_attribute_value_id` → `product_template_attribute_value.id` (Inferred from standard Odoo naming conventions for join tables).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; queries should expect multiple rows per `purchase_order_line_id` if a product has multiple attributes configured.
- There are no timestamps or audit columns present; this table represents the current state of the relationship as captured during the last ingestion.
- Ensure joins to parent tables handle potential missing records if the source system has performed cascading deletes or if the staging extract is incomplete.