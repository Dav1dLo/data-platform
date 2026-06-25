# hr_employee_cv_wizard

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`hr_employee_cv_wizard`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value for the `id` column.

## Functional process 
This table supports the Human Resources module, specifically the configuration or "wizard" process for generating employee CVs or resumes. It stores user-defined preferences for document styling and content visibility, such as color schemes and toggles for displaying skills or contact information.

## Description
One row in this table represents a single configuration instance for an employee CV generation wizard. It serves as a raw landed copy of the wizard's state, capturing the visual and content-related settings selected by a user during the document creation process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `hr_employee_cv_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users`. |
| color_primary | VARCHAR | false | Primary color code for the CV | Likely a hex code or CSS color name. |
| color_secondary | VARCHAR | false | Secondary color code for the CV | Likely a hex code or CSS color name. |
| show_skills | BOOLEAN | true | Toggle to include skills section | Nulls may imply a default state of false. |
| show_contact | BOOLEAN | true | Toggle to include contact information | Nulls may imply a default state of false. |
| show_others | BOOLEAN | true | Toggle to include other sections | Nulls may imply a default state of false. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Tracks the creator of the wizard configuration.
    - `write_uid` → `res_users.id`: Tracks the last modifier of the wizard configuration.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The table does not appear to implement soft deletes; standard `SELECT` queries will retrieve all records.
- Boolean columns (`show_skills`, `show_contact`, `show_others`) may contain `NULL` values; treat these as `FALSE` or check application-level defaults if necessary.
- This is a staging table; data is likely transient and intended for configuration purposes rather than long-term historical reporting.