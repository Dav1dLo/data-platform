# sale_advance_payment_inv

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`sale_advance_payment_inv`), the use of `create_uid`/`write_uid` for audit tracking, and the specific sequence-based default value for the `id` column.

## Functional process 
This table supports the Sales Order invoicing process, specifically managing the configuration and execution of advance payments (down payments). It tracks how advance payments are structured—whether by a fixed amount or percentage—and whether those payments should be deducted from final invoices or consolidated into billing.

## Description
One row in this table represents a specific configuration or record of an advance payment request associated with a sales order. It serves as a raw landed staging entity, capturing the parameters and financial values defined during the creation of an advance payment invoice in the Odoo sales module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sale_advance_payment_inv_id_seq` |
| currency_id | INTEGER | true | Foreign key to currency | Likely references `res_currency` |
| company_id | INTEGER | true | Foreign key to company | Likely references `res_company` |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users` |
| advance_payment_method | VARCHAR | false | Strategy for the advance payment | e.g., 'fixed', 'percentage' |
| fixed_amount | NUMERIC | true | The specific amount for the advance | Used if method is 'fixed' |
| deduct_down_payments | BOOLEAN | true | Flag to deduct from final invoice | |
| consolidated_billing | BOOLEAN | true | Flag for consolidated invoicing | |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed |
| amount | DOUBLE PRECISION | true | Total amount of the advance | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `currency_id` → `res_currency.id` (Standard Odoo naming convention for currency references).
    - `company_id` → `res_company.id` (Standard Odoo naming convention for multi-company isolation).
    - `create_uid` → `res_users.id` (Standard Odoo audit field for creator).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for updater).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As a staging table, this may contain transient records or incomplete configurations depending on the Odoo wizard state at the time of extraction.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted or persisted indefinitely.
- **Precision:** `fixed_amount` uses `NUMERIC` for exact financial precision, while `amount` uses `DOUBLE PRECISION`, which may introduce floating-point rounding artifacts; prefer `fixed_amount` for financial calculations where possible.