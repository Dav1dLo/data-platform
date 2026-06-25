# account_payment_method

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the financial configuration and payment processing module. It defines the available payment methods (e.g., credit card, bank transfer, cash) that can be associated with customer invoices or vendor payments within the accounting or billing workflow.

## Description
Each row represents a distinct payment method configuration available within the system. This is a raw landing table in the staging layer, containing metadata about how payments are categorized and processed. The grain of the table is one row per unique payment method identifier.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.account_payment_method_id_seq` |
| create_uid | INTEGER | true | ID of the user who created the record | References system user table |
| write_uid | INTEGER | true | ID of the user who last modified the record | References system user table |
| code | VARCHAR | false | Internal short code for the payment method | Used for system-level identification |
| payment_type | VARCHAR | false | Categorization of the payment method | e.g., 'inbound', 'outbound' |
| name | JSONB | false | Display name of the payment method | Likely contains multi-language translations |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC |
| write_date | TIMESTAMP | true | Timestamp of last record modification | Assumed UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column)
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column)
- **Natural keys (inferred):** 
    - `code`: The internal identifier is typically unique for payment method definitions.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` column is `JSONB` and may contain localized strings; while unlikely to contain PII, it should be inspected if used in reporting.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As a staging table, this may contain records that have been logically updated; always prefer the record with the most recent `write_date` if duplicates appear.
- **JSONB:** The `name` column requires specific PostgreSQL JSONB operators (e.g., `->>`) to extract text values for standard reporting.