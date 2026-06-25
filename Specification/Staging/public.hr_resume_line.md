# hr_resume_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_resume_line`), the use of `create_uid`/`write_uid` audit columns, and the `JSONB` data types commonly used in Odoo for multi-language or structured content fields.

## Functional process 
This table supports the Human Resources module, specifically the management of employee professional history, education, or certification records. It tracks chronological entries associated with an employee profile, likely powering the "Resume" or "CV" view within the HR application.

## Description
One row in this table represents a single entry in an employee's resume or professional profile, such as a specific job tenure, degree, or certification. The grain is one row per resume line item per employee. As a staging table, it serves as a raw, direct copy of the operational HR data, intended for downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_resume_line_id_seq`. |
| employee_id | INTEGER | false | Foreign key to the employee | Links to the primary HR employee record. |
| line_type_id | INTEGER | true | Category of the resume entry | Likely references a lookup table for types like 'Experience' or 'Education'. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who performed the initial entry. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who performed the last modification. |
| display_type | VARCHAR | true | UI rendering hint | Used by the application to determine how to format the line in the UI. |
| date_start | DATE | false | Start date of the entry | The beginning of the period covered by this resume line. |
| date_end | DATE | true | End date of the entry | The end of the period; null implies an ongoing role. |
| name | JSONB | false | Title or header of the entry | Contains the primary text, often localized. |
| description | JSONB | true | Detailed content of the entry | Contains additional context or bullet points. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in server time (typically UTC). |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server time (typically UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `employee_id` → `hr_employee.id` (Guess: Standard Odoo naming convention for employee links).
    - `line_type_id` → `hr_resume_line_type.id` (Guess: Standard Odoo naming convention for category lookups).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB content:** The `name` and `description` columns contain JSONB data; ensure your downstream transformation logic handles potential nested structures or language-specific keys.
- **Timestamps:** `create_date` and `write_date` are stored in the application server's timezone (typically UTC); verify against system settings if precise local time is required.
- **Soft deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records present are currently active in the source system.
- **Data integrity:** As a staging table, expect potential inconsistencies in `line_type_id` if the source system allows orphaned records during bulk imports.