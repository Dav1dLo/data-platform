# payment_method

## Source system
The table likely originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the use of `nextval` sequences and `JSONB` for localized fields, is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the payment processing and checkout configuration pipeline. It defines the available payment methods (e.g., credit card, bank transfer, digital wallets) and their functional capabilities, such as whether they support tokenization, express checkout, or refunds.

## Description
One row represents a single payment method configuration available within the platform. This is a raw staging table containing the metadata and feature flags for payment providers, serving as the source for downstream payment integration logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `payment_method_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort methods in the UI. |
| primary_payment_method_id | INTEGER | true | Self-referencing parent ID | Likely links sub-methods to a primary provider. |
| create_uid | INTEGER | true | Creator user ID | References the internal user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the internal user who last updated the record. |
| code | VARCHAR | false | Internal system code | Unique identifier for the payment method (e.g., 'stripe', 'paypal'). |
| support_refund | VARCHAR | false | Refund capability flag | Indicates if the method supports automated refunds. |
| name | JSONB | false | Display name | Multi-language label for the payment method. |
| active | BOOLEAN | true | Soft-delete flag | If false, the method is hidden from the checkout flow. |
| support_tokenization | BOOLEAN | true | Tokenization capability | Indicates if the method supports saving payment details. |
| support_express_checkout | BOOLEAN | true | Express checkout capability | Indicates if the method supports one-click payment flows. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `primary_payment_method_id` → `public.payment_method.id`: References the parent payment method configuration.
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** 
    - `code`: The internal system identifier is typically unique across the platform.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = true` to retrieve only currently enabled methods.
- **JSONB:** The `name` column contains JSONB data; use the `->>` operator (e.g., `name->>'en_US'`) to extract specific language strings.
- **Data Integrity:** As a staging table, this may contain raw, unvalidated configuration data; ensure joins are handled carefully if the source system allows duplicate codes.