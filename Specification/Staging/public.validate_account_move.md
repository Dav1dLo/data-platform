# validate_account_move

## Source system
This table originates from an Odoo ERP system. The naming convention `validate_account_move` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal transient or wizard models used to manage accounting journal entry validation processes.

## Functional process 
This table supports the accounting "Journal Entry Validation" process. It acts as a configuration or transient state store that captures user-defined parameters (such as `force_post` or flags to ignore abnormal dates/amounts) when a user triggers the validation of an account move (journal entry) within the financial module.

## Description
One row in this table represents a single validation request or configuration instance for an account move. It serves as a staging record that holds the specific validation settings applied by a user during the posting process. This is a raw landed copy of the Odoo transient model data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `validate_account_move_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| force_post | BOOLEAN | true | Flag to force posting | If true, overrides standard validation checks. |
| ignore_abnormal_date | BOOLEAN | true | Flag to bypass date warnings | Allows posting despite unusual transaction dates. |
| ignore_abnormal_amount | BOOLEAN | true | Flag to bypass amount warnings | Allows posting despite unusual transaction values. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (based on Odoo naming convention for user references).
    - `write_uid` → `res_users.id` (based on Odoo naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which link to internal system users; no direct PII is present in this table.
- **Data Lifecycle:** As a transient/wizard table in Odoo, rows may be ephemeral or frequently purged depending on the system's vacuum/cleanup policies.
- **Boolean Logic:** Null values in boolean columns should be treated as `FALSE` in business logic, as Odoo often defaults these to false in the application layer.