# stock_warn_insufficient_qty_unbuild

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo's ORM, and the `unbuild_id` reference which relates to Odoo's Manufacturing (MRP) module.

## Functional process 
This table supports the inventory management and manufacturing process, specifically tracking warnings or alerts generated when there is insufficient stock quantity to complete an "unbuild" operation. It acts as a diagnostic or notification log for warehouse managers to identify which products at specific locations are blocking manufacturing unbuild orders.

## Description
One row in this table represents a single instance of an insufficient quantity warning triggered during an unbuild process for a specific product at a specific location. It serves as a raw landed staging entity, capturing the state of inventory alerts at the time of the unbuild attempt.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_warn_insufficient_qty_unbuild_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | References the product involved in the unbuild. |
| location_id | INTEGER | false | Foreign key to location | References the warehouse location where stock is insufficient. |
| unbuild_id | INTEGER | true | Foreign key to unbuild order | References the specific unbuild operation that triggered the warning. |
| create_uid | INTEGER | true | Creator user ID | References the user who triggered the warning. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| product_uom_name | VARCHAR | false | Unit of measure name | The display name of the unit of measure for the quantity. |
| create_date | TIMESTAMP | true | Record creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Likely in UTC. |
| quantity | DOUBLE PRECISION | false | Insufficient quantity | The amount of stock missing to complete the unbuild. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo naming pattern).
    - `location_id` → `stock_location.id` (Standard Odoo naming pattern).
    - `unbuild_id` → `mrp_unbuild.id` (Standard Odoo naming pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `unbuild_id` is nullable, suggesting some warnings may be orphaned or generated in contexts where a formal unbuild order record does not exist.
- **Soft Deletes:** This table does not contain an `active` or `deleted_at` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Precision:** The `quantity` column uses `DOUBLE PRECISION`, which may introduce floating-point rounding artifacts; cast to `DECIMAL` for financial or precise inventory reporting.