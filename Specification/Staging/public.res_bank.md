# res_bank

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`res_bank`, `create_uid`, `write_uid`, `write_date`) and the use of standard Odoo sequence generators for the primary key.

## Functional process 
This table supports the master data management process for financial institutions. It acts as a central repository for bank details used across the platform for payment processing, vendor/customer bank account configuration, and treasury management.

## Description
One row in this table represents a single bank entity, including its contact information, address, and Bank Identifier Code (BIC). As a staging table, it serves as a raw, direct copy of the Odoo `res.bank` model, intended for downstream integration into dimensional models or operational reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_bank_id_seq` sequence. |
| state | INTEGER | true | Foreign key to state/province | Likely references `res_country_state.id`. |
| country | INTEGER | true | Foreign key to country | Likely references `res_country.id`. |
| create_uid | INTEGER | true | Creator user ID | References `res_users.id`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res_users.id`. |
| name | VARCHAR | false | Bank name | Display name of the institution. |
| street | VARCHAR | true | Street address line 1 | Physical address component. |
| street2 | VARCHAR | true | Street address line 2 | Physical address component. |
| zip | VARCHAR | true | Postal code | - |
| city | VARCHAR | true | City name | - |
| email | VARCHAR | true | Contact email | - |
| phone | VARCHAR | true | Contact phone number | - |
| bic | VARCHAR | true | Bank Identifier Code | SWIFT/BIC code for international transfers. |
| active | BOOLEAN | true | Soft-delete flag | If false, the bank is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `state` → `res_country_state.id` (Inferred from Odoo standard naming).
    - `country` → `res_country.id` (Inferred from Odoo standard naming).
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming).
- **Natural keys (inferred):** 
    - `bic` (While not always unique in legacy systems, it is the standard business identifier for banks).

## Caveats for downstream consumers

- **Sensitive Data:** The `email` and `phone` columns contain contact information and should be handled according to PII policies.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing historical audits.
- **Timestamps:** `create_date` and `write_date` are stored in the application's timezone (typically UTC in Odoo).
- **Data Integrity:** As a staging table, this may contain incomplete records or duplicates if the source system allows manual entry without strict validation on the `bic` field.