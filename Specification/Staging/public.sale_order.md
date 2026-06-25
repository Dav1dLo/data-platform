# sale_order

## Source system
This table originates from Odoo ERP. The naming conventions (e.g., `partner_id`, `create_uid`, `write_uid`, `fiscal_position_id`, `picking_policy`) and the specific structure of the audit fields are characteristic of the Odoo `sale.order` model.

## Functional process 
This table supports the Order-to-Cash business process. It captures the lifecycle of a sales order from initial quotation through to confirmation, delivery, and invoicing, tracking financial totals, customer relationships, and logistical requirements.

## Description
One row represents a single sales order or quotation within the ERP system. It acts as the central header record for a transaction, containing references to the customer, pricing, shipping, and current state. In this staging layer, it serves as a raw, direct copy of the Odoo database table, intended for downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| campaign_id | INTEGER | true | Marketing campaign ID | Link to marketing module. |
| source_id | INTEGER | true | Marketing source ID | Link to marketing module. |
| medium_id | INTEGER | true | Marketing medium ID | Link to marketing module. |
| company_id | INTEGER | false | Company ID | Multi-company context. |
| partner_id | INTEGER | false | Customer ID | The primary customer/partner. |
| journal_id | INTEGER | true | Accounting journal ID | Linked financial journal. |
| partner_invoice_id | INTEGER | false | Invoice address ID | Link to partner address. |
| partner_shipping_id | INTEGER | false | Shipping address ID | Link to partner address. |
| fiscal_position_id | INTEGER | true | Fiscal position ID | Tax/accounting mapping. |
| payment_term_id | INTEGER | true | Payment terms ID | Defines due dates. |
| pricelist_id | INTEGER | true | Pricelist ID | Pricing strategy applied. |
| currency_id | INTEGER | true | Currency ID | Transaction currency. |
| user_id | INTEGER | true | Salesperson ID | Owner of the order. |
| team_id | INTEGER | true | Sales team ID | Sales department. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created. |
| write_uid | INTEGER | true | Modifier user ID | Audit: user who last updated. |
| access_token | INTEGER | true | Portal access token | For customer portal view. |
| name | VARCHAR | false | Order reference number | Human-readable order ID. |
| state | VARCHAR | true | Order status | e.g., draft, sent, sale, done. |
| client_order_ref | VARCHAR | true | Customer PO number | External reference. |
| origin | VARCHAR | true | Source document | e.g., linked quotation. |
| reference | VARCHAR | true | Internal reference | Additional notes/ref. |
| signed_by | VARCHAR | true | Signatory name | Digital signature info. |
| invoice_status | VARCHAR | true | Invoicing status | e.g., to invoice, invoiced. |
| validity_date | DATE | true | Expiration date | For quotations. |
| note | TEXT | true | Internal/external notes | Free-text field. |
| currency_rate | NUMERIC | true | Currency exchange rate | Rate at time of order. |
| amount_untaxed | NUMERIC | true | Net amount | Total before tax. |
| amount_tax | NUMERIC | true | Tax amount | Total tax value. |
| amount_total | NUMERIC | true | Gross amount | Total order value. |
| locked | BOOLEAN | true | Lock status | Prevents further edits. |
| require_signature | BOOLEAN | true | Signature requirement | Flag for online signing. |
| require_payment | BOOLEAN | true | Payment requirement | Flag for online payment. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit: record creation. |
| commitment_date | TIMESTAMP | true | Commitment date | Promised delivery date. |
| date_order | TIMESTAMP | false | Order date | Transaction date. |
| signed_on | TIMESTAMP | true | Signature timestamp | When signed. |
| write_date | TIMESTAMP | true | Modification timestamp | Audit: last update. |
| prepayment_percent | DOUBLE PRECISION | true | Prepayment percentage | Required deposit %. |
| pending_email_template_id | INTEGER | true | Email template ID | For pending communications. |
| opportunity_id | INTEGER | true | CRM Opportunity ID | Link to sales pipeline. |
| sale_order_template_id | INTEGER | true | Order template ID | Predefined order structure. |
| incoterm | INTEGER | true | Incoterm ID | International trade terms. |
| warehouse_id | INTEGER | true | Warehouse ID | Fulfillment location. |
| procurement_group_id | INTEGER | true | Procurement group ID | Inventory grouping. |
| incoterm_location | VARCHAR | true | Incoterm location | Specific port/place. |
| picking_policy | VARCHAR | false | Picking policy | e.g., direct, one-shot. |
| delivery_status | VARCHAR | true | Delivery status | e.g., pending, delivered. |
| effective_date | TIMESTAMP | true | Effective date | Actual fulfillment date. |
| amount_unpaid | NUMERIC | true | Outstanding balance | Remaining amount due. |
| customizable_pdf_form_fields | JSONB | true | PDF form data | Dynamic form inputs. |
| project_id | INTEGER | true | Project ID | Linked project (if any). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: standard Odoo partner link)
    - `user_id` → `res_users.id` (Guess: standard Odoo user link)
    - `company_id` → `res_company.id` (Guess: standard Odoo company link)
    - `opportunity_id` → `crm_lead.id` (Guess: standard Odoo CRM link)
- **Natural keys (inferred):** 
    - `name` (The unique order sequence number assigned by the system)

## Caveats for downstream consumers

- **Sensitive Data:** `client_order_ref` and `note` may contain PII; `access_token` should be treated as a credential.
- **Timestamps:** All timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually hard-deleted or archived via state changes.
- **Data Integrity:** `amount_untaxed`, `amount_tax`, and `amount_total` should be validated against line items in `sale_order_line` (if available) as they are often calculated fields.