# account_secure_entries_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the accounting integrity and audit process, specifically the "Secure Entries" wizard functionality. It tracks the generation of cryptographic hashes for accounting entries to ensure data immutability and compliance with fiscal reporting regulations.

## Description
One row in this table represents a single execution or configuration instance of the "Secure Entries" wizard for a specific company. It serves as a raw landed staging record capturing the audit trail of when and by whom the secure hashing process was initiated.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_secure_entries_wizard_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organization for which the entries are secured. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| hash_date | DATE | false | Target date for hashing | The specific date for which accounting entries are being secured. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the wizard record was created. |
| write_date | TIMESTAMP | true | Record modification timestamp | Timestamp of the last update to this record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company isolation).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record ownership).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user metadata tables to resolve names.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by the Odoo framework.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), which is common in other Odoo tables; assume all records are active.
- **Data Integrity:** As a staging table, this reflects the raw state of the wizard configuration and may contain multiple entries per company if the wizard was run multiple times for the same `hash_date`.