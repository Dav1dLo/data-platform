# hr_skill_level

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on `hr_skill_level_id_seq`).

## Functional process 
This table supports the Human Resources module, specifically the skills management and employee competency tracking process. It defines the hierarchical or categorical levels (e.g., "Beginner", "Advanced", "Expert") associated with various skill types, allowing the organization to quantify employee proficiency.

## Description
One row in this table represents a specific proficiency level definition within a skill category. It serves as a raw landed staging entity, capturing the configuration of skill levels used to evaluate employee performance and development.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `hr_skill_level_id_seq` |
| skill_type_id | INTEGER | true | Foreign key to the parent skill category | Links to a skill type definition |
| level_progress | INTEGER | true | Numerical representation of proficiency | Likely a percentage or score |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users` |
| name | VARCHAR | false | Descriptive name of the skill level | e.g., "Junior", "Senior" |
| default_level | BOOLEAN | true | Flag indicating if this is the default level | Used for initial skill assignment |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed |
| write_date | TIMESTAMP | true | Timestamp of last record update | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `skill_type_id` → `hr_skill_type.id` (Inferred from Odoo naming conventions for skill modules).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable; the combination of `name` and `skill_type_id` is a likely candidate for a business key.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `skill_type_id` is nullable, which may indicate orphaned records or global skill levels not tied to a specific type.
- This table contains no PII, but `create_uid` and `write_uid` link to internal system users.
- There is no explicit soft-delete flag; assume records are hard-deleted if they disappear from the source.