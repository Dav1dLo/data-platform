# report_pos_order

## Source system
This table originates from an Odoo ERP system, specifically the Point of Sale (POS) module. The naming conventions (e.g., `product_tmpl_id`, `pos_categ_id`, `journal_id`) and the structure of the reporting metrics are characteristic of Odoo's internal analytical reporting models for retail transactions.

## Functional process 
This table supports the retail sales reporting and performance analysis pipeline. It aggregates transactional data from the Point of Sale to track sales volume, margins, discounts, and product performance, facilitating business intelligence tasks such as daily revenue reporting and employee sales tracking.

## Description
One row in this table represents a single line item or an aggregated summary record within a Point of Sale order. It serves as a raw landed staging entity, capturing the financial and operational state of POS transactions at the time of ingestion from the Odoo source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely an internal Odoo record ID. |
| nbr_lines | INTEGER | true | Number of lines in the order | Indicates the count of items in the transaction. |
| date | TIMESTAMP | true | Transaction timestamp | Assumed UTC. |
| price_subtotal_excl | NUMERIC | true | Subtotal excluding tax | Currency unit depends on company configuration. |
| product_qty | NUMERIC | true | Quantity of product sold | Can be fractional. |
| price_sub_total | NUMERIC | true | Subtotal including tax | Often used for net revenue calculations. |
| price_total | NUMERIC | true | Total price including tax | Final amount paid by customer. |
| total_discount | NUMERIC | true | Total discount amount | Absolute value of discounts applied. |
| average_price | NUMERIC | true | Average unit price | Calculated as total / quantity. |
| delay_validation | INTEGER | true | Validation delay | Time taken to finalize the order. |
| order_id | INTEGER | true | Foreign key to POS order | Links to the parent order header. |
| partner_id | INTEGER | true | Customer ID | Links to the partner/customer record. |
| state | VARCHAR | true | Order status | e.g., 'paid', 'done', 'invoiced'. |
| user_id | INTEGER | true | User ID | The system user who processed the order. |
| company_id | INTEGER | true | Company ID | Multi-company identifier. |
| journal_id | INTEGER | true | Accounting journal ID | Links to the financial journal. |
| product_id | INTEGER | true | Product variant ID | Specific product sold. |
| product_categ_id | INTEGER | true | Product category ID | Category hierarchy link. |
| product_tmpl_id | INTEGER | true | Product template ID | Links to the base product definition. |
| config_id | INTEGER | true | POS configuration ID | Links to the specific POS terminal/setup. |
| pricelist_id | INTEGER | true | Pricelist ID | The pricing strategy applied. |
| session_id | INTEGER | true | POS session ID | Links to the specific POS work session. |
| invoiced | BOOLEAN | true | Invoiced status | Flag indicating if an invoice was generated. |
| margin | NUMERIC | true | Profit margin | Calculated as revenue minus cost. |
| payment_method_id | INTEGER | true | Payment method ID | Links to the payment type used. |
| pos_categ_id | INTEGER | true | POS category ID | Category specific to POS display. |
| employee_id | INTEGER | true | Employee ID | The staff member who performed the sale. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `pos_order.id` (links to the main order record)
    - `product_id` → `product_product.id` (links to the specific product variant)
    - `partner_id` → `res_partner.id` (links to the customer/partner)
    - `employee_id` → `hr_employee.id` (links to the staff member)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC; verify against Odoo system settings if local timezone offsets are observed.
- **Data Quality:** As a staging table, this may contain duplicate records if the ingestion process is not idempotent or if the source system performs updates that result in multiple versions of the same `id`.
- **Sensitivity:** Contains `partner_id` which may link to PII (customer names/emails) in other tables.
- **Soft Deletes:** Odoo typically uses `active` flags; check if any such column exists or if records are physically removed.