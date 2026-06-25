# sale_order_line

## Source system
This table originates from Odoo ERP. The naming conventions (e.g., `sale_order_line`, `product_uom`, `create_uid`, `write_uid`, `analytic_distribution`) and the specific structure of fields like `display_type` and `is_downpayment` are characteristic of the Odoo Sales module's database schema.

## Functional process 
This table supports the Order-to-Cash process, specifically managing the individual line items associated with sales orders. It tracks product quantities, pricing, discounts, and fulfillment status (delivered/invoiced) for each line, facilitating revenue recognition and inventory allocation.

## Description
One row in this table represents a single line item within a sales order, detailing the product, quantity, and financial metrics for that specific entry. As a staging table, it serves as a raw, landed copy of the Odoo `sale_order_line` model, capturing the state of order lines at the time of extraction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `sale_order_line_id_seq`. |
| order_id | INTEGER | false | Foreign key to the parent sales order | Links to the header record. |
| sequence | INTEGER | true | Display order sequence | Used for UI ordering of lines. |
| company_id | INTEGER | true | Company identifier | Multi-company context. |
| currency_id | INTEGER | true | Currency identifier | |
| order_partner_id | INTEGER | true | Customer/Partner identifier | |
| salesman_id | INTEGER | true | Salesperson identifier | |
| product_id | INTEGER | true | Product identifier | |
| product_uom | INTEGER | true | Unit of measure identifier | |
| linked_line_id | INTEGER | true | Reference to a parent/linked line | Used for bundles or kits. |
| combo_item_id | INTEGER | true | Combo item identifier | |
| product_packaging_id | INTEGER | true | Packaging identifier | |
| create_uid | INTEGER | true | User ID who created the record | |
| write_uid | INTEGER | true | User ID who last updated the record | |
| state | VARCHAR | true | Lifecycle state of the line | e.g., 'draft', 'sale', 'cancel'. |
| display_type | VARCHAR | true | Line display type | e.g., 'line_section', 'line_note'. |
| virtual_id | VARCHAR | true | Virtual identifier | |
| linked_virtual_id | VARCHAR | true | Linked virtual identifier | |
| qty_delivered_method | VARCHAR | true | Delivery calculation method | |
| invoice_status | VARCHAR | true | Invoicing status | e.g., 'to invoice', 'invoiced'. |
| analytic_distribution | JSONB | true | Analytic account distribution | JSON structure for cost centers. |
| name | TEXT | false | Line description | |
| product_uom_qty | NUMERIC | false | Quantity ordered | |
| price_unit | NUMERIC | false | Unit price | |
| discount | NUMERIC | true | Discount percentage | |
| price_subtotal | NUMERIC | true | Subtotal excluding tax | |
| price_total | NUMERIC | true | Total including tax | |
| price_reduce_taxexcl | NUMERIC | true | Reduced price excluding tax | |
| price_reduce_taxinc | NUMERIC | true | Reduced price including tax | |
| qty_delivered | NUMERIC | true | Quantity delivered | |
| qty_invoiced | NUMERIC | true | Quantity invoiced | |
| qty_to_invoice | NUMERIC | true | Quantity remaining to invoice | |
| untaxed_amount_invoiced | NUMERIC | true | Amount already invoiced (untaxed) | |
| untaxed_amount_to_invoice | NUMERIC | true | Amount remaining to invoice (untaxed) | |
| is_downpayment | BOOLEAN | true | Downpayment flag | |
| is_expense | BOOLEAN | true | Expense flag | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Record last update timestamp | |
| technical_price_unit | DOUBLE PRECISION | true | Technical unit price | |
| price_tax | DOUBLE PRECISION | true | Tax amount | |
| product_packaging_qty | DOUBLE PRECISION | true | Packaging quantity | |
| customer_lead | DOUBLE PRECISION | false | Expected lead time in days | |
| route_id | INTEGER | true | Logistics route identifier | |
| warehouse_id | INTEGER | true | Warehouse identifier | |
| is_service | BOOLEAN | true | Service product flag | |
| project_id | INTEGER | true | Project identifier | |
| task_id | INTEGER | true | Task identifier | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `order_id` → `sale_order.id` (Links to the parent sales order header).
    - `product_id` → `product_product.id` (Identifies the item being sold).
    - `company_id` → `res_company.id` (Identifies the owning entity).
- **Natural keys (inferred):**
    - Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** Odoo typically performs hard deletes on records; however, check for `active` flags if present in other related tables.
- **Data Types:** `analytic_distribution` is a `JSONB` field; ensure your downstream processing can parse nested JSON structures.
- **Precision:** Financial fields (`price_subtotal`, `price_total`) use `NUMERIC` for exact precision; avoid casting to `FLOAT` to prevent rounding errors.