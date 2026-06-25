# hr_resume_line_type

## Source system
This table likely originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields (common in Odoo's multi-language support).

## Functional process 
This table supports the Human Resources module, specifically managing the configuration of resume line types (e.g., "Education", "Experience", "Certification"). It defines the categories used to structure a candidate's or employee's resume profile.

## Description
One row represents a single category or type of resume entry available within the HR system. It serves as a reference lookup table in the staging layer, providing the descriptive labels used to classify resume data points.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_resume_line_type_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort types in UI dropdowns. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| name | JSONB | false | Display name | Likely contains localized strings (e.g., `{"en_US": "Education", "fr_FR": "Éducation"}`). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Localization:** The `name` column is `JSONB`; queries should use the `->>` operator to extract specific language keys (e.g., `name->>'en_US'`).
- **Timestamps:** All `_date` columns are assumed to be in UTC.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume all records are currently active unless otherwise specified by business logic.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal system user IDs and may not resolve if the `res_users` table is not present in the same schema.