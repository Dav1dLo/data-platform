# res_partner

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `res_partner` is the standard internal table name for the "Partners" model in Odoo, which serves as the central repository for all entities the system interacts with, including customers, suppliers, and internal company contacts.

## Functional process 
This table supports the "Party Management" and "Customer/Supplier Relationship Management" processes. It acts as the master data store for all business entities, tracking contact details, financial properties (payment terms, credit limits), and operational flags (supplier/customer ranks) used across the sales, purchasing, and accounting modules.

## Description
One row in this table represents a single partner entity, which can be an individual person, a company, or a specific branch/address of a company. It acts as a raw landed copy of the Odoo `res.partner` model, capturing the full state of the entity including hierarchical relationships, geographic data, and configuration settings for automated workflows.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | true | Related company ID | Links to the specific Odoo company context. |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| name | VARCHAR | true | Display name | |
| title | INTEGER | true | Partner title/salutation ID | |
| parent_id | INTEGER | true | Parent partner ID | Used for hierarchical company structures. |
| user_id | INTEGER | true | Assigned salesperson/user ID | |
| state_id | INTEGER | true | State/Province ID | |
| country_id | INTEGER | true | Country ID | |
| industry_id | INTEGER | true | Industry sector ID | |
| color | INTEGER | true | UI color index | |
| commercial_partner_id | INTEGER | true | Commercial entity ID | Links to the top-level parent company. |
| create_uid | INTEGER | true | Creator user ID | |
| write_uid | INTEGER | true | Last modifier user ID | |
| complete_name | VARCHAR | true | Full hierarchical name | |
| ref | VARCHAR | true | Internal reference code | |
| lang | VARCHAR | true | Language code | e.g., 'en_US'. |
| tz | VARCHAR | true | Timezone | |
| vat | VARCHAR | true | Tax identification number | |
| company_registry | VARCHAR | true | Company registration number | |
| website | VARCHAR | true | Website URL | |
| function | VARCHAR | true | Job title/function | |
| type | VARCHAR | true | Address type | e.g., 'invoice', 'delivery'. |
| street | VARCHAR | true | Street address | |
| street2 | VARCHAR | true | Street address line 2 | |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City | |
| email | VARCHAR | true | Email address | |
| phone | VARCHAR | true | Phone number | |
| mobile | VARCHAR | true | Mobile number | |
| commercial_company_name | VARCHAR | true | Commercial company name | |
| company_name | VARCHAR | true | Company name | |
| barcode | JSONB | true | Barcode data | |
| comment | TEXT | true | Internal notes | |
| partner_latitude | NUMERIC | true | Latitude coordinate | |
| partner_longitude | NUMERIC | true | Longitude coordinate | |
| active | BOOLEAN | true | Soft-delete flag | |
| employee | BOOLEAN | true | Is internal employee | |
| is_company | BOOLEAN | true | Is a company entity | |
| partner_share | BOOLEAN | true | Is a partner share | |
| write_date | TIMESTAMP | true | Last modification timestamp | |
| message_bounce | INTEGER | true | Email bounce count | |
| email_normalized | VARCHAR | true | Normalized email address | |
| signup_type | VARCHAR | true | Portal signup type | |
| calendar_last_notif_ack | TIMESTAMP | true | Last calendar notification ack | |
| specific_property_product_pricelist | JSONB | true | Pricelist configuration | |
| partner_gid | INTEGER | true | Global ID | |
| additional_info | VARCHAR | true | Extra info | |
| phone_sanitized | VARCHAR | true | Sanitized phone number | |
| invoice_template_pdf_report_id | INTEGER | true | Custom invoice report ID | |
| supplier_rank | INTEGER | true | Supplier status rank | |
| customer_rank | INTEGER | true | Customer status rank | |
| invoice_warn | VARCHAR | true | Invoice warning type | |
| autopost_bills | VARCHAR | false | Auto-post bills setting | |
| credit_limit | JSONB | true | Credit limit configuration | |
| property_account_payable_id | JSONB | true | Payable account ID | |
| property_account_receivable_id | JSONB | true | Receivable account ID | |
| property_account_position_id | JSONB | true | Fiscal position ID | |
| property_payment_term_id | JSONB | true | Payment term ID | |
| property_supplier_payment_term_id | JSONB | true | Supplier payment term ID | |
| trust | JSONB | true | Trust level | |
| ignore_abnormal_invoice_date | JSONB | true | Ignore date warnings | |
| ignore_abnormal_invoice_amount | JSONB | true | Ignore amount warnings | |
| invoice_sending_method | JSONB | true | Sending method | |
| invoice_edi_format_store | JSONB | true | EDI format | |
| property_outbound_payment_method_line_id | JSONB | true | Outbound payment method | |
| property_inbound_payment_method_line_id | JSONB | true | Inbound payment method | |
| invoice_warn_msg | TEXT | true | Invoice warning message | |
| debit_limit | NUMERIC | true | Debit limit amount | |
| picking_warn | VARCHAR | true | Picking warning type | |
| property_stock_customer | JSONB | true | Customer stock location | |
| property_stock_supplier | JSONB | true | Supplier stock location | |
| picking_warn_msg | TEXT | true | Picking warning message | |
| website_id | INTEGER | true | Website ID | |
| is_published | BOOLEAN | true | Published status | |
| global_location_number | VARCHAR | true | GLN code | |
| peppol_endpoint | VARCHAR | true | Peppol endpoint | |
| peppol_eas | VARCHAR | true | Peppol EAS code | |
| buyer_id | INTEGER | true | Buyer ID | |
| purchase_warn | VARCHAR | true | Purchase warning type | |
| property_purchase_currency_id | JSONB | true | Purchase currency ID | |
| receipt_reminder_email | JSONB | true | Receipt reminder email | |
| reminder_date_before_receipt | JSONB | true | Reminder lead time | |
| purchase_warn_msg | TEXT | true | Purchase warning message | |
| sale_warn | VARCHAR | true | Sale warning type | |
| sale_warn_msg | TEXT | true | Sale warning message | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `res_partner.id` (Self-referencing hierarchy)
    - `country_id` → `res_country.id` (Likely target for country lookups)
    - `user_id` → `res_users.id` (Likely target for internal user/salesperson)
- **Natural keys (inferred):** 
    - `vat` (Tax ID, often unique per country)
    - `email` (Primary contact email)

## Caveats for downstream consumers

- **Sensitive Data:** Contains PII including `email`, `phone`, `mobile`, `street`, and `vat`. Masking is recommended for non-authorized users.
- **Soft Deletes:** The `active` column is a boolean flag. Rows where `active = false` should generally be excluded from standard reporting.
- **JSONB Columns:** Many financial properties (e.g., `credit_limit`, `property_account_receivable_id`) are stored as `JSONB`. These require specific PostgreSQL operators (e.g., `->>`) to extract values for analysis.
- **Timestamps:** Timestamps are generally stored in UTC, but verify against the Odoo server configuration if precision is critical.