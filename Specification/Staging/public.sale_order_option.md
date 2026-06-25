# sale_order_option

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions (`create_uid`, `write_uid`, `write_date`) and the specific sequence-based primary key pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the sales order management process, specifically handling optional products or add-ons associated with a sales quotation or order. It tracks the configuration of these optional items, including their pricing, quantities, and discounts, linked to the primary sales order.

## Description
One row represents a single optional product line item associated with a specific sales order. It serves as a raw landed staging entity, capturing the state of optional order configurations as they exist in the source ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sale_order_option_id_seq`. |
| order_id | INTEGER | true | Foreign key to the parent sales order | Links to the main order header. |
| product_id | INTEGER | false | Identifier for the optional product | References the product catalog. |
| line_id | INTEGER | true | Identifier for the related order line | Optional link to a specific line item. |
| sequence | INTEGER | true | Display order index | Used for UI sorting in the source system. |
| uom_id | INTEGER | false | Unit of Measure identifier | Defines the unit for the quantity. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | TEXT | false | Description of the option | The display name for the optional item. |
| quantity | NUMERIC | false | Quantity of the optional item | The amount requested. |
| price_unit | NUMERIC | false | Unit price of the option | Base price before discounts. |
| discount | NUMERIC | true | Discount percentage | Expressed as a percentage. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `sale_order.id` (Inferred from naming convention and business context).
    - `product_id` → `product_product.id` (Inferred from standard Odoo schema patterns).
    - `uom_id` → `uom_uom.id` (Inferred from standard Odoo schema patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Sensitive Data:** No direct PII is present, though `create_uid` and `write_uid` link to internal user identities.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume standard CRUD behavior where records are removed physically if deleted in the source.
- **Data Quality:** `order_id` is nullable, which may indicate orphaned records or options not yet attached to a finalized order.