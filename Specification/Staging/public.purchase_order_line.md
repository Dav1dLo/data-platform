# purchase_order_line

## Source system
This table originates from Odoo ERP. The naming conventions (e.g., `product_uom`, `create_uid`, `write_uid`, `analytic_distribution`, `qty_received_method`) and the specific sequence-based primary key pattern are characteristic of the Odoo framework's database schema.

## Functional process 
This table supports the procurement and purchasing lifecycle, specifically the "Procure-to-Pay" process. It tracks individual line items within a purchase order, capturing details on requested quantities, unit pricing, tax calculations, and the status of goods receipt and invoicing for each specific product or service ordered.

## Description
One row in this table represents a single line item within a purchase order, detailing the specific product, quantity, and financial terms associated with that line. As a staging table, it serves as a raw landed copy of the Odoo `purchase.order.line` model, maintaining the grain of one row per line item per purchase order.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `purchase_order_line_id_seq`. |
| sequence | INTEGER | true | Display order sequence | Used for UI ordering of lines. |
| product_uom | INTEGER | true | Unit of measure ID | Foreign key to `uom_uom`. |
| product_id | INTEGER | true | Product ID | Foreign key to `product_product`. |
| order_id | INTEGER | false | Parent purchase order ID | Foreign key to `purchase_order`. |
| company_id | INTEGER | true | Company ID | Multi-company context. |
| partner_id | INTEGER | true | Vendor/Partner ID | Foreign key to `res_partner`. |
| currency_id | INTEGER | true | Currency ID | Foreign key to `res_currency`. |
| product_packaging_id | INTEGER | true | Packaging ID | Reference to product packaging. |
| create_uid | INTEGER | true | Creator user ID | Audit field. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field. |
| state | VARCHAR | true | Line status | e.g., 'draft', 'purchase', 'done'. |
| qty_received_method | VARCHAR | true | Receipt tracking method | e.g., 'manual', 'stock_moves'. |
| display_type | VARCHAR | true | Line display type | Used for section headers or notes. |
| analytic_distribution | JSONB | true | Analytic accounting split | JSON mapping for cost centers. |
| name | TEXT | false | Line description | Product name or description. |
| product_qty | NUMERIC | false | Ordered quantity | Base quantity. |
| discount | NUMERIC | true | Discount percentage | Applied to unit price. |
| price_unit | NUMERIC | false | Unit price | Price per unit. |
| price_subtotal | NUMERIC | true | Subtotal amount | Pre-tax total. |
| price_total | NUMERIC | true | Total amount | Post-tax total. |
| qty_invoiced | NUMERIC | true | Invoiced quantity | Quantity processed for billing. |
| qty_received | NUMERIC | true | Received quantity | Quantity confirmed as delivered. |
| qty_received_manual | NUMERIC | true | Manually adjusted receipt | Override for received quantity. |
| qty_to_invoice | NUMERIC | true | Remaining quantity to bill | Calculated balance. |
| is_downpayment | BOOLEAN | true | Downpayment flag | Indicates if line is a deposit. |
| date_planned | TIMESTAMP | true | Scheduled delivery date | Target date for receipt. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC. |
| product_uom_qty | DOUBLE PRECISION | true | UoM-adjusted quantity | Often redundant with `product_qty`. |
| price_tax | DOUBLE PRECISION | true | Tax amount | Calculated tax for the line. |
| product_packaging_qty | DOUBLE PRECISION | true | Packaging quantity | Multiplier for packaging. |
| orderpoint_id | INTEGER | true | Reordering rule ID | Link to `stock_warehouse_orderpoint`. |
| location_final_id | INTEGER | true | Destination location ID | Link to `stock_location`. |
| group_id | INTEGER | true | Procurement group ID | Link to `procurement_group`. |
| product_description_variants | VARCHAR | true | Product variant description | Additional text for variants. |
| propagate_cancel | BOOLEAN | true | Cancel propagation flag | Whether to cancel linked moves. |
| sale_order_id | INTEGER | true | Linked sale order ID | For dropshipping or back-to-back. |
| sale_line_id | INTEGER | true | Linked sale order line ID | For dropshipping or back-to-back. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `order_id` → `purchase_order.id`: Mandatory link to the parent order.
    - `product_id` → `product_product.id`: Identifies the item being purchased.
    - `partner_id` → `res_partner.id`: Identifies the vendor associated with the line.
- **Natural keys (inferred):**
    - No single natural key is present; the row is uniquely identified by the combination of `order_id` and `sequence` (or `id`).

## Caveats for downstream consumers

- **Timestamps:** All `_date` fields are stored in UTC.
- **Soft Deletes:** Odoo typically performs hard deletes on records; however, check for `active` flags if present in related tables.
- **Precision:** `NUMERIC` fields are used for financial calculations; ensure appropriate rounding is applied in downstream transformations.
- **JSONB:** The `analytic_distribution` column contains complex nested data; use PostgreSQL JSONB operators (e.g., `->>`) to extract values.
- **Redundancy:** Several quantity fields (`product_qty` vs `product_uom_qty`) may overlap depending on the Odoo version; verify which is the source of truth for your specific instance.