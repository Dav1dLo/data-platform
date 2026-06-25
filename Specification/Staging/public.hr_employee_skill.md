# hr_employee_skill

## Source system
The table likely originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of Postgres sequence-based default values for the primary key.

## Functional process 
This table supports the Human Resources management process, specifically tracking employee competency profiles. It maps individual employees to specific skills and their associated proficiency levels, likely used for resource allocation, training gap analysis, or project staffing.

## Description
One row in this table represents a single skill assignment for a specific employee, including the proficiency level and the category of the skill. This is a raw landing table in the staging layer, serving as a direct reflection of the source system's relational link between employees and their skill sets.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `hr_employee_skill_id_seq` |
| employee_id | INTEGER | false | Foreign key to the employee | Links to the employee master record |
| skill_id | INTEGER | false | Foreign key to the skill definition | Identifies the specific skill |
| skill_level_id | INTEGER | false | Foreign key to the proficiency level | Defines the depth of knowledge |
| skill_type_id | INTEGER | false | Foreign key to the skill category | Groups skills by type |
| create_uid | INTEGER | true | User ID who created the record | Audit field |
| write_uid | INTEGER | true | User ID who last updated the record | Audit field |
| create_date | TIMESTAMP | true | Timestamp of record creation | Audit field |
| write_date | TIMESTAMP | true | Timestamp of last update | Audit field |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `hr_employee.id` (Inferred from standard Odoo naming patterns)
    - `skill_id` → `hr_skill.id` (Inferred from standard Odoo naming patterns)
    - `skill_level_id` → `hr_skill_level.id` (Inferred from standard Odoo naming patterns)
    - `skill_type_id` → `hr_skill_type.id` (Inferred from standard Odoo naming patterns)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Audit Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo/Postgres deployments.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are currently active unless filtered by business logic in the source system.
- **Data Integrity:** As a staging table, this may contain orphaned records if the source system does not enforce strict referential integrity at the database level.
- **PII:** While this table contains no direct PII (like names or emails), it links to employee records which are sensitive; ensure appropriate access controls are applied when joining to PII-heavy tables.