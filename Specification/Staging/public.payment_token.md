# payment_token

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the payment processing and subscription billing module. It stores tokenized payment method references provided by external payment gateways (e.g., Stripe, Authorize.net) to facilitate recurring billing or one-click checkout flows without storing raw credit card data.

## Description
One row represents a single payment token associated with a specific payment method and partner. It serves as a raw landed copy of the payment gateway's reference data, used to link internal system entities to external payment provider records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `payment_token_id_seq`. |
| provider_id | INTEGER | false | ID of the payment provider | Links to a payment provider configuration table. |
| company_id | INTEGER | true | ID of the owning company | Multi-tenant identifier. |
| payment_method_id | INTEGER | false | ID of the payment method | Links to the internal payment method definition. |
| partner_id | INTEGER | false | ID of the customer/partner | The entity to whom this token belongs. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail for modification. |
| payment_details | VARCHAR | true | Masked or JSON payment info | Likely contains metadata about the card/account. |
| provider_ref | VARCHAR | false | External gateway reference | The unique token ID issued by the payment provider. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the token is currently valid for use. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: standard Odoo pattern for customer linkage).
    - `provider_id` → `payment_provider.id` (Guess: links to the gateway configuration).
- **Natural keys (inferred):** 
    - `provider_ref` (The external gateway token is the unique business identifier).

## Caveats for downstream consumers

- **Sensitive Data:** `payment_details` may contain PII or sensitive payment metadata; ensure appropriate masking policies are applied.
- **Timestamps:** All `_date` columns are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing audit analysis.
- **Odoo Pattern:** This is a standard Odoo `ir.model` structure; `create_uid` and `write_uid` refer to the internal `res.users` table.