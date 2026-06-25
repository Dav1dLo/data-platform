# payment_transaction

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `_id` suffixes for relational links, which are standard in Odoo's PostgreSQL schema.

## Functional process 
This table supports the payment processing and reconciliation pipeline. It tracks the lifecycle of financial transactions initiated through various payment providers, linking them to internal partners (customers), point-of-sale orders, and specific payment methods.

## Description
One row represents a single payment transaction attempt or execution, capturing the financial amount, current state, and associated metadata. This is a raw landing table in the staging layer, containing a denormalized snapshot of transaction details including partner contact information and provider-specific references.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `payment_transaction_id_seq` |
| provider_id | INTEGER | false | ID of the payment provider | Foreign key to provider table |
| company_id | INTEGER | true | ID of the company | Multi-company context |
| payment_method_id | INTEGER | false | ID of the payment method | e.g., Credit Card, Bank Transfer |
| currency_id | INTEGER | false | ID of the currency | ISO currency reference |
| token_id | INTEGER | true | ID of the payment token | Used for recurring payments |
| source_transaction_id | INTEGER | true | ID of the parent transaction | Used for refunds or captures |
| partner_id | INTEGER | false | ID of the customer/partner | Links to partner master data |
| partner_state_id | INTEGER | true | ID of the partner's state/province | Geographic context |
| partner_country_id | INTEGER | true | ID of the partner's country | Geographic context |
| create_uid | INTEGER | true | User ID who created the record | Audit trail |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail |
| reference | VARCHAR | false | Internal transaction reference | Business-level identifier |
| provider_reference | VARCHAR | true | External reference from provider | e.g., Stripe/PayPal transaction ID |
| state | VARCHAR | false | Current status of the transaction | e.g., 'pending', 'done', 'error' |
| operation | VARCHAR | true | Type of operation | e.g., 'online_direct', 'validation' |
| landing_route | VARCHAR | true | URL or route for landing | |
| partner_name | VARCHAR | true | Name of the partner | Denormalized for audit |
| partner_lang | VARCHAR | true | Language code of the partner | |
| partner_email | VARCHAR | true | Email address of the partner | PII |
| partner_address | VARCHAR | true | Physical address of the partner | PII |
| partner_zip | VARCHAR | true | Postal code of the partner | |
| partner_city | VARCHAR | true | City of the partner | |
| partner_phone | VARCHAR | true | Phone number of the partner | PII |
| state_message | TEXT | true | Error or status message | |
| amount | NUMERIC | false | Transaction amount | |
| is_post_processed | BOOLEAN | true | Flag for post-processing status | |
| tokenize | BOOLEAN | true | Flag to enable tokenization | |
| last_state_change | TIMESTAMP | true | Timestamp of last state update | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Record last update timestamp | |
| payment_id | INTEGER | true | ID of the related payment record | |
| is_donation | BOOLEAN | true | Flag for donation transactions | |
| pos_order_id | INTEGER | true | ID of the related POS order | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo naming for customer records)
    - `currency_id` → `res_currency.id` (Standard Odoo naming for currency records)
    - `pos_order_id` → `pos_order.id` (Links to Point of Sale module)
- **Natural keys (inferred):** 
    - `reference` (The internal business reference string)

## Caveats for downstream consumers

- **PII:** This table contains sensitive customer information (`partner_email`, `partner_phone`, `partner_address`) which should be masked or restricted based on data governance policies.
- **Timestamps:** Timestamps (`create_date`, `write_date`, `last_state_change`) are typically stored in UTC in Odoo environments, but verify against the application server configuration.
- **Denormalization:** The table contains denormalized partner details (name, address, email). These may drift from the master `res_partner` table; always prefer the master table for current contact information.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually hard-deleted or updated. Assume this table represents the current state of transactions.