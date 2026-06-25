# purchase_order

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `partner_ref`, `incoterm_id`, and the use of sequence-based primary keys (`nextval('"public".purchase_order_id_seq'::regclass)`).

## Functional process 
This table supports the procurement and purchasing lifecycle, specifically tracking the "Procure-to-Pay" process. It captures the header-level details of purchase orders, including financial totals, approval states, vendor references, and logistics information like incoterms and planned delivery dates.

## Description
One row represents a single purchase order header record within the procurement system. It serves as a raw landed copy of the purchase order entity, containing the current state, financial values, and audit metadata for each order.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated |
| partner_id | INTEGER | false | Vendor/Supplier identifier | Links to partner master |
| dest_address_id | INTEGER | true | Delivery destination address ID | |
| currency_id | INTEGER | false | Currency identifier | |
| invoice_count | INTEGER | true | Number of associated invoices | |
| fiscal_position_id | INTEGER | true | Tax mapping rule ID | |
| payment_term_id | INTEGER | true | Payment terms identifier | |
| incoterm_id | INTEGER | true | International Commercial Terms ID | |
| user_id | INTEGER | true | Responsible purchaser/buyer ID | |
| company_id | INTEGER | false | Owning company/branch ID | |
| create_uid | INTEGER | true | User ID who created the record | |
| write_uid | INTEGER | true | User ID who last updated the record | |
| access_token | INTEGER | true | Security token for external access | |
| name | VARCHAR | false | Purchase order reference number | e.g., PO001 |
| priority | VARCHAR | true | Order priority level | |
| origin | VARCHAR | true | Source document reference | |
| partner_ref | VARCHAR | true | Vendor's own order reference | |
| state | VARCHAR | true | Current lifecycle status | e.g., draft, sent, purchase, done |
| invoice_status | VARCHAR | true | Billing status | |
| notes | TEXT | true | Internal or vendor notes | |
| amount_untaxed | NUMERIC | true | Order total before tax | |
| amount_tax | NUMERIC | true | Total tax amount | |
| amount_total | NUMERIC | true | Total order value | |
| amount_total_cc | NUMERIC | true | Total value in company currency | |
| currency_rate | NUMERIC | true | Exchange rate applied | |
| mail_reminder_confirmed | BOOLEAN | true | Email reminder confirmation status | |
| mail_reception_confirmed | BOOLEAN | true | Email reception confirmation status | |
| mail_reception_declined | BOOLEAN | true | Email reception declined status | |
| date_order | TIMESTAMP | false | Order creation/confirmation date | |
| date_approve | TIMESTAMP | true | Approval timestamp | |
| date_planned | TIMESTAMP | true | Expected delivery date | |
| date_calendar_start | TIMESTAMP | true | Calendar start date | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Record last update timestamp | |
| project_id | INTEGER | true | Linked project identifier | |
| picking_type_id | INTEGER | false | Inventory picking operation type | |
| group_id | INTEGER | true | Procurement group identifier | |
| incoterm_location | VARCHAR | true | Specific location for incoterm | |
| receipt_status | VARCHAR | true | Goods receipt status | |
| effective_date | TIMESTAMP | true | Actual effective date | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo vendor link)
    - `currency_id` → `res_currency.id` (Standard Odoo currency link)
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
- **Natural keys (inferred):** 
    - `name` (The purchase order number is typically unique within the system)

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` column; assume records are hard-deleted if removed from the source.
- **Sensitive Data:** `access_token` should be treated as a sensitive credential and excluded from general reporting.
- **Financials:** `amount_total` and `amount_total_cc` may differ based on currency conversion; ensure the correct column is used for financial reporting.