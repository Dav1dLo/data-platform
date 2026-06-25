# hr_skill_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_skill_type`), the use of `create_uid`/`write_uid` audit columns, and the `JSONB` data type for the `name` field, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the Human Resources management module, specifically the configuration of skill categories or types (e.g., "Technical Skills", "Languages", "Soft Skills"). It provides the taxonomy used to categorize individual employee skills within the HR information system.

## Description
One row in this table represents a single skill category definition used to group specific employee competencies. This is a raw staging table containing the direct landing of the Odoo `hr.skill.type` model, intended to serve as a lookup or dimension reference for downstream HR reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `hr_skill_type_id_seq`. |
| color | INTEGER | true | UI display color index | Used for visual categorization in the Odoo frontend. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system users table. |
| name | JSONB | false | Skill type label | Stores localized strings; usually contains keys for language codes. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the skill type is currently enabled. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp of initial ingestion. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`. To extract the English label, you will likely need to query it using `name->>'en_US'` or similar, depending on your instance's configured languages.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless historical/deleted records are explicitly required.
- This table is a staging entity; expect raw, uncleaned data including potential system-level metadata.