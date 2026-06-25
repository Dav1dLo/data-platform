# vendor_delay_report

## Source system
The table likely originates from an ERP system such as Odoo or a similar modular business management suite. The naming convention (e.g., `partner_id`, `purchase_line_id`, `product_id`) is highly characteristic of Odoo's PostgreSQL schema, which frequently uses these specific identifiers to link procurement and supply chain modules.

## Functional process 
This table supports the procurement and supply chain performance monitoring process. It tracks vendor reliability by comparing total quantities ordered against quantities delivered on time, allowing for the calculation of vendor lead-time performance and fulfillment accuracy metrics.

## Description
One row in this table represents a daily summary of procurement performance for a specific product line item associated with a vendor. It serves as a raw landed staging entity, capturing granular delivery metrics to facilitate downstream reporting on supply chain delays and vendor service level agreements (SLAs).

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely an auto-incrementing identifier from the source. |
| date | TIMESTAMP | true | Transaction or report date | Represents the point in time the performance was recorded. |
| purchase_line_id | INTEGER | true | Foreign key to purchase order line | Links to the specific line item in the procurement system. |
| product_id | INTEGER | true | Foreign key to product catalog | Identifies the item being procured. |
| category_id | INTEGER | true | Foreign key to product category | Used for grouping performance metrics by product type. |
| partner_id | INTEGER | true | Foreign key to vendor/partner | Identifies the supplier associated with the purchase. |
| qty_total | DOUBLE PRECISION | true | Total quantity ordered | The aggregate volume expected for the given line item. |
| qty_on_time | NUMERIC | true | Quantity delivered on time | The portion of the total quantity that met the delivery deadline. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `purchase_line_id` → `purchase_order_line.id` (Guess: links to procurement line details).
    - `product_id` → `product_product.id` (Guess: links to the master product list).
    - `category_id` → `product_category.id` (Guess: links to product classification).
    - `partner_id` → `res_partner.id` (Guess: links to the vendor master record).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data Quality:** All columns are marked as nullable; expect missing values in historical records or incomplete ingestion batches.
- **Timestamps:** Assumed to be in UTC; verify against source system configuration if time-zone sensitive calculations are required.
- **Soft Deletes:** This table does not explicitly indicate a soft-delete flag; assume all rows are active unless a `deleted_at` or `active` column is introduced in future schema versions.
- **Precision:** `qty_total` uses `DOUBLE PRECISION` while `qty_on_time` uses `NUMERIC`; be mindful of potential floating-point arithmetic errors when calculating delay percentages.