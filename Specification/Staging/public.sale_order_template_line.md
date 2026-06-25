# sale_order_template_line

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `sale_order_template_line`, `product_uom_id`, `create_uid`, `write_date`) and the use of `JSONB` for localized fields are characteristic of the Odoo framework's database schema.

## Functional process 
This table supports the "Quote/Template Management" process. It stores the individual line items associated with predefined sale order templates, allowing users to quickly populate sales orders with standard sets of products, quantities, and descriptions.

## Description
One row represents a single line item within a sale order template, defining the product, quantity, and unit of measure associated with that template. As a staging table, it serves as a raw, direct ingestion of the Odoo `sale.order.template.line` model, preserving the original structure for downstream transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `sale_order_template_line_id_seq`. |
| sale_order_template_id | INTEGER | false | Foreign key to the parent template | Links to the `sale.order.template` header. |
| sequence | INTEGER | true | Display order index | Determines the order of lines in the UI. |
| company_id | INTEGER | true | Owning company ID | Multi-company context identifier. |
| product_id | INTEGER | true | Product identifier | Links to the `product.product` table. |
| product_uom_id | INTEGER | true | Unit of measure ID | Links to the `uom.uom` table. |
| create_uid | INTEGER | true | Creator user ID | Links to `res.users` for the record creator. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res.users` for the last editor. |
| display_type | VARCHAR | true | Line type indicator | Used to distinguish between sections, notes, or products. |
| name | JSONB | true | Line description | Localized text content for the template line. |
| product_uom_qty | NUMERIC | false | Quantity | The amount of the product to be included. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sale_order_template_id` → `sale_order_template.id` (Evidence: standard Odoo naming convention for parent-child relationships).
    - `product_id` → `product_product.id` (Evidence: standard Odoo naming convention for product links).
    - `company_id` → `res_company.id` (Evidence: standard Odoo multi-company architecture).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **JSONB:** The `name` column contains JSONB data; ensure your downstream processing handles potential multi-language keys or nested structures.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume records are hard-deleted if missing from source.
- **Data Integrity:** As a staging table, this may contain orphaned records if the parent `sale_order_template` was deleted.