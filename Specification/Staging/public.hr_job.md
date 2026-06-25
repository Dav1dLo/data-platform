# hr_job

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for localized fields (like `name`), and the specific sequence-based primary key pattern (`hr_job_id_seq`).

## Functional process 
This table supports the Recruitment or Human Resources module, specifically managing job openings and vacancy tracking. It tracks the lifecycle of a job position, including headcount requirements (`expected_employees`), current staffing levels (`no_of_employee`), and the recruitment status associated with specific departments and companies.

## Description
One row in this table represents a single job position or vacancy record within the organization. It serves as a raw landed copy from the Odoo staging layer, capturing the definition, requirements, and administrative metadata for each job opening.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `hr_job_id_seq` sequence. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| expected_employees | INTEGER | true | Target headcount | Number of employees planned for this role. |
| no_of_employee | INTEGER | true | Current headcount | Number of employees currently in this role. |
| no_of_recruitment | INTEGER | true | Open vacancy count | Number of active recruitment slots. |
| department_id | INTEGER | true | Foreign key to department | Links to the hiring department. |
| company_id | INTEGER | true | Foreign key to company | Links to the legal entity. |
| contract_type_id | INTEGER | true | Foreign key to contract type | Links to employment terms. |
| create_uid | INTEGER | true | Creator user ID | Links to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Links to the user who last updated the record. |
| name | JSONB | false | Job title | Likely contains multi-language strings. |
| description | TEXT | true | Job description | Full text of the job posting. |
| requirements | TEXT | true | Job requirements | List of skills or qualifications. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the job posting is currently active. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `department_id` → `hr_department.id` (Standard Odoo naming convention).
    - `company_id` → `res_company.id` (Standard Odoo naming convention).
    - `contract_type_id` → `hr_contract_type.id` (Standard Odoo naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; you will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract specific language values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `active` column acts as a soft-delete flag; ensure your queries filter by `active = true` if you only want current, non-archived job postings.
- This is a raw staging table; expect potential duplicates or uncleaned data if the upstream Odoo instance undergoes frequent manual edits.