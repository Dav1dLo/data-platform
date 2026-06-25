# hr_employee_skill_log

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the Human Resources skill management and professional development process. It tracks the historical progression and assignment of specific skills to employees, likely used to monitor competency levels and training progress within departments.

## Description
One row represents a single log entry or update regarding an employee's proficiency level in a specific skill. As a staging table, it serves as a raw, landed copy of the operational HR skill log, capturing the state of skill acquisition and progress at a specific point in time.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_employee_skill_log_id_seq`. |
| employee_id | INTEGER | false | Foreign key to the employee | Links to the employee profile. |
| department_id | INTEGER | true | Foreign key to the department | Optional; indicates the department context of the skill. |
| skill_id | INTEGER | false | Foreign key to the skill definition | Identifies the specific skill being logged. |
| skill_level_id | INTEGER | false | Foreign key to the skill level | Defines the proficiency tier. |
| skill_type_id | INTEGER | false | Foreign key to the skill category | Groups the skill into a broader type. |
| level_progress | INTEGER | true | Numerical progress indicator | Likely a percentage or score within the current level. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to the system user table. |
| date | DATE | true | Effective date of the log entry | Business date associated with the skill update. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp of ingestion. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC timestamp of last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `hr_employee.id` (Guess: standard Odoo naming pattern)
    - `department_id` → `hr_department.id` (Guess: standard Odoo naming pattern)
    - `skill_id` → `hr_skill.id` (Guess: standard Odoo naming pattern)
    - `skill_level_id` → `hr_skill_level.id` (Guess: standard Odoo naming pattern)
    - `skill_type_id` → `hr_skill_type.id` (Guess: standard Odoo naming pattern)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `employee_id` and user audit IDs; ensure access is restricted to authorized HR personnel.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC.
- **Data Integrity:** The `department_id` is nullable, meaning some skill logs may not be associated with a specific department in the source system.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are current unless filtered by `date`.