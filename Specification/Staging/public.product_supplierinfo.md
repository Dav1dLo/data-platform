# product_supplierinfo

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `product_tmpl_id`, `create_uid`, `write_uid`, `product_supplierinfo`) and the specific sequence-based primary key pattern are characteristic of the Odoo ORM's underlying database schema.

## Functional process 
This table supports the procurement and supply chain management process, specifically managing vendor price lists and lead times for products. It tracks the relationship between products (or product templates) and their respective suppliers, including pricing, minimum order quantities, and delivery delays.

## Description
One row in this table represents a specific supplier's pricing and lead time configuration for a product or product template. It serves as a raw landed staging entity, capturing the historical and current vendor agreements used to automate purchase order generation and cost estimation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `product_supplierinfo_id_seq`. |
| partner_id | INTEGER | false | Vendor identifier | Foreign key to the partner/supplier table. |
| sequence | INTEGER | true | Priority order | Used to determine the order of preference for suppliers. |
| company_id | INTEGER | true | Company identifier | Multi-company context; null implies global availability. |
| currency_id | INTEGER | false | Currency identifier | Foreign key to the currency table. |
| product_id | INTEGER | true | Product variant ID | Specific product variant; null if applicable to all variants. |
| product_tmpl_id | INTEGER | true | Product template ID | Generic product definition; linked to `product_id`. |
| delay | INTEGER | false | Lead time in days | Expected delivery time from the supplier. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | Reference to the user who last modified the record. |
| product_name | VARCHAR | true | Supplier product name | The name used by the vendor for this item. |
| product_code | VARCHAR | true | Supplier product code | The SKU or part number used by the vendor. |
| date_start | DATE | true | Validity start date | The date from which this price list entry is active. |
| date_end | DATE | true | Validity end date | The date after which this price list entry expires. |
| min_qty | NUMERIC | false | Minimum quantity | The minimum order quantity required for this price. |
| price | NUMERIC | false | Unit price | The cost per unit offered by the supplier. |
| discount | NUMERIC | true | Discount percentage | Applied discount on the unit price. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Inferred from Odoo standard naming for vendor links).
    - `currency_id` → `res_currency.id` (Inferred from Odoo standard naming).
    - `product_id` → `product_product.id` (Inferred from Odoo standard naming).
    - `product_tmpl_id` → `product_template.id` (Inferred from Odoo standard naming).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains internal pricing and vendor relationship data; ensure access is restricted to procurement and finance roles.
- **Timestamps:** `create_date` and `write_date` are typically stored in UTC in Odoo environments.
- **Soft Deletes:** Odoo does not typically use soft-delete flags; records are usually physically deleted unless an `active` column (not present here) is used.
- **Data Grain:** A record may apply to a specific `product_id` (variant) or a `product_tmpl_id` (all variants); queries should handle both cases to avoid double-counting.