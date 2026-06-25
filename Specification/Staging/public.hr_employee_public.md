# hr_employee_public

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_date`, `resource_calendar_id`) and the specific structure of HR-related fields are characteristic of the Odoo `hr.employee` model.

## Functional process 
This table supports the Human Resources management process, specifically employee lifecycle and directory management. It tracks organizational assignments (department, job title), contact information, and resource scheduling attributes within the company hierarchy.

## Description
One row in this table represents a single employee record within the organization. It serves as a raw landed copy of the Odoo employee master data, capturing both personal contact details and internal system identifiers for resource management and reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| name | VARCHAR | true | Full name of the employee | |
| active | BOOLEAN | true | Soft-delete flag | True if the employee is currently active |
| color | INTEGER | true | UI color index | Used for calendar or dashboard categorization |
| department_id | INTEGER | true | Foreign key to department | |
| job_id | INTEGER | true | Foreign key to job position | |
| job_title | VARCHAR | true | Descriptive job title | |
| company_id | INTEGER | true | Foreign key to company | |
| address_id | INTEGER | true | Foreign key to partner/address | |
| work_phone | VARCHAR | true | Work phone number | |
| mobile_phone | VARCHAR | true | Mobile phone number | |
| work_email | VARCHAR | true | Work email address | PII |
| work_contact_id | INTEGER | true | Foreign key to contact record | |
| work_location_id | INTEGER | true | Foreign key to work location | |
| user_id | INTEGER | true | Foreign key to system user | Links employee to a login account |
| resource_id | INTEGER | true | Foreign key to resource | |
| resource_calendar_id | INTEGER | true | Foreign key to calendar | Defines working hours |
| is_flexible | BOOLEAN | true | Flexibility flag | |
| is_fully_flexible | BOOLEAN | true | Full flexibility flag | |
| parent_id | INTEGER | true | Manager/Supervisor ID | Self-referencing foreign key |
| coach_id | INTEGER | true | Coach/Mentor ID | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| id | INTEGER | true | Internal surrogate key | |
| create_uid | INTEGER | true | User ID who created the record | |
| write_uid | INTEGER | true | User ID who last updated the record | |
| write_date | TIMESTAMP | true | Last update timestamp | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `department_id` → `hr_department.id` (Likely reference to department table)
    - `company_id` → `res_company.id` (Likely reference to company table)
    - `user_id` → `res_users.id` (Likely reference to system users table)
    - `parent_id` → `hr_employee_public.id` (Self-reference for reporting lines)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII:** Contains `work_email`, `work_phone`, and `mobile_phone`. Ensure appropriate masking for non-HR users.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing historical analysis.
- **Data Quality:** As a staging table, this may contain duplicates or incomplete records if the source system allows partial employee creation.