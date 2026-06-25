# account_payment_term

## Source system
This table originates from an Odoo ERP system. The presence of columns like `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized fields (`name`, `note`) are characteristic patterns of the Odoo ORM framework.

## Functional process 
This table supports the "Order-to-Cash" and "Procure-to-Pay" business processes by defining the payment terms available for invoices and bills. It governs how early payment discounts are calculated and how payment deadlines are presented to customers or vendors.

## Description
One row represents a single payment term configuration, such as "Net 30" or "2% 10, Net 30". This is a raw landed staging table containing the configuration settings for payment terms, including discount logic and display preferences, used to drive financial document generation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_payment_term_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Links to the multi-company context. |
| sequence | INTEGER | false | Sort order for UI display | Determines the order in dropdowns. |
| discount_days | INTEGER | true | Days allowed for early payment | Used in discount calculation logic. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| early_pay_discount_computation | VARCHAR | true | Strategy for discount calculation | e.g., 'fixed', 'percentage'. |
| name | JSONB | false | Display name of the payment term | Multi-language support via JSONB. |
| note | JSONB | true | Descriptive text for the invoice | Multi-language support via JSONB. |
| active | BOOLEAN | true | Soft-delete flag | If false, the term is hidden from UI. |
| display_on_invoice | BOOLEAN | true | Visibility toggle | Whether to print on invoice documents. |
| early_discount | BOOLEAN | true | Early payment discount flag | Indicates if this term supports discounts. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| discount_percentage | DOUBLE PRECISION | true | Discount rate | Expressed as a decimal (e.g., 0.02 for 2%). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Fields:** The `name` and `note` columns contain JSONB data. You will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract specific language values.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure your queries filter by `active = true` unless you intend to include historical/archived terms.
- **Data Types:** `discount_percentage` is a float; ensure precision handling is appropriate for financial calculations.