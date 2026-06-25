# res_currency_rate

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_currency_rate` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the multi-currency accounting and financial reporting process. It maintains the historical exchange rates used to convert transaction amounts into the company's base currency, allowing the system to perform accurate financial consolidation and reporting across different currencies.

## Description
One row in this table represents a specific exchange rate for a currency on a given date. It serves as a raw landed copy of the currency rate configuration from the source ERP, capturing the conversion factor relative to the base currency for a specific company.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_currency_rate_id_seq`. |
| currency_id | INTEGER | false | Foreign key to the currency definition | Links to the currency being valued. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the company context for the rate; null implies a global rate. |
| create_uid | INTEGER | true | User ID who created the record | Audit field for record creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit field for record modification. |
| name | DATE | false | Effective date of the exchange rate | The date for which this rate is applicable. |
| rate | NUMERIC | true | Exchange rate value | The conversion factor. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id`: Standard Odoo pattern for linking rates to currency definitions.
    - `company_id` → `res_company.id`: Standard Odoo pattern for multi-company scoping.
- **Natural keys (inferred):** 
    - `(currency_id, name, company_id)`: The combination of currency, date, and company typically defines a unique rate entry in Odoo.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database practices.
- **Data Sensitivity:** No PII is present in this table.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically managed via direct updates or inserts.
- **Rate Precision:** The `rate` column is `NUMERIC`; ensure appropriate rounding is applied when performing currency conversions in downstream models to avoid floating-point errors.