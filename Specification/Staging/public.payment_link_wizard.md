# payment_link_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `res_id`, `res_model`, `create_uid`, and `write_uid`, which are standard patterns for Odoo's ORM-based data structures.

## Functional process 
This table supports the "Payment Link Generation" process, likely used to create ad-hoc payment requests or invoices for customers. It tracks the configuration of payment links, including associated partners, currency, and installment structures, facilitating the transition from a business record (e.g., an invoice or sales order) to a payable link.

## Description
One row represents a single instance of a payment link wizard configuration, capturing the parameters required to generate a payment request for a specific business object. This is a raw staging table, serving as a direct landing of the application's wizard state before any business logic or transformation is applied.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| res_id | INTEGER | false | ID of the related business object | References the record being paid. |
| currency_id | INTEGER | true | Foreign key to currency | Links to the currency definition. |
| partner_id | INTEGER | true | Foreign key to partner | The customer or entity associated with the link. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| res_model | VARCHAR | false | Model name of the related object | Identifies the source entity type (e.g., 'account.move'). |
| amount | NUMERIC | false | Target payment amount | The primary amount requested. |
| amount_max | NUMERIC | true | Maximum allowed payment amount | Used for partial or capped payment scenarios. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |
| discount_date | DATE | true | Early payment discount deadline | Date threshold for discount eligibility. |
| open_installments | JSONB | true | Installment schedule details | Stores structured data for payment plans. |
| has_eligible_epd | BOOLEAN | true | Early payment discount eligibility | Flag indicating if the link qualifies for a discount. |
| amount_paid | NUMERIC | true | Total amount already paid | Tracks progress against the target amount. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Guess: standard Odoo naming for currency tables).
    - `partner_id` → `res_partner.id` (Guess: standard Odoo naming for customer/vendor tables).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and potentially sensitive financial amounts; ensure appropriate access controls are applied.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Structure:** The `open_installments` column is `JSONB`, which requires specific PostgreSQL operators (e.g., `->>`, `jsonb_array_elements`) to parse in downstream SQL.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by the source system's business logic.