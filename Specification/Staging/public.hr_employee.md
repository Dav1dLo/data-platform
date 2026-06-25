# hr_employee

## Source system
This table originates from Odoo ERP, indicated by the characteristic naming conventions such as `resource_id`, `create_uid`, `write_uid`, `message_main_attachment_id`, and the use of `JSONB` for `employee_properties`. The schema structure is typical of the Odoo `hr.employee` model.

## Functional process 
This table supports the Human Resources management process, specifically employee lifecycle management. It tracks organizational data (department, job, manager), contact information (work and private), and compliance/legal documentation (SSN, visa, passport, work permits). It serves as the central registry for employee profiles within the ERP.

## Description
One row in this table represents a single employee record, capturing both professional and personal details. It acts as a raw landed copy of the Odoo `hr.employee` model, maintaining the grain of one row per unique employee identifier.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated |
| resource_id | INTEGER | false | Link to resource management | Odoo resource framework |
| company_id | INTEGER | false | Owning company ID | Multi-company support |
| resource_calendar_id | INTEGER | true | Working schedule ID | |
| message_main_attachment_id | INTEGER | true | ID of main attachment | |
| color | INTEGER | true | UI color index | |
| department_id | INTEGER | true | Department reference | |
| job_id | INTEGER | true | Job position reference | |
| address_id | INTEGER | true | Work address reference | |
| work_contact_id | INTEGER | true | Work contact reference | |
| work_location_id | INTEGER | true | Work location reference | |
| user_id | INTEGER | true | Linked system user ID | |
| parent_id | INTEGER | true | Manager/Supervisor ID | Self-referencing |
| coach_id | INTEGER | true | Coach/Mentor ID | |
| private_state_id | INTEGER | true | Private address state/province | |
| private_country_id | INTEGER | true | Private address country | |
| country_id | INTEGER | true | Nationality/Country ID | |
| children | INTEGER | true | Number of children | |
| country_of_birth | INTEGER | true | Country of birth ID | |
| bank_account_id | INTEGER | true | Primary bank account ID | |
| distance_home_work | INTEGER | true | Commute distance | |
| km_home_work | INTEGER | true | Commute distance in KM | |
| departure_reason_id | INTEGER | true | Reason for leaving | |
| create_uid | INTEGER | true | Creator user ID | |
| write_uid | INTEGER | true | Last modifier user ID | |
| name | VARCHAR | true | Employee full name | |
| job_title | VARCHAR | true | Job title description | |
| work_phone | VARCHAR | true | Work phone number | |
| mobile_phone | VARCHAR | true | Mobile phone number | |
| work_email | VARCHAR | true | Work email address | |
| private_street | VARCHAR | true | Private address street | PII |
| private_street2 | VARCHAR | true | Private address street 2 | PII |
| private_city | VARCHAR | true | Private address city | PII |
| private_zip | VARCHAR | true | Private address zip code | PII |
| private_phone | VARCHAR | true | Private phone number | PII |
| private_email | VARCHAR | true | Private email address | PII |
| lang | VARCHAR | true | Preferred language | |
| gender | VARCHAR | true | Gender | |
| marital | VARCHAR | false | Marital status | |
| spouse_complete_name | VARCHAR | true | Spouse name | PII |
| place_of_birth | VARCHAR | true | City of birth | |
| ssnid | VARCHAR | true | Social Security Number | PII |
| sinid | VARCHAR | true | Social Insurance Number | PII |
| identification_id | VARCHAR | true | National ID number | PII |
| passport_id | VARCHAR | true | Passport number | PII |
| permit_no | VARCHAR | true | Work permit number | PII |
| visa_no | VARCHAR | true | Visa number | PII |
| certificate | VARCHAR | true | Education level | |
| study_field | VARCHAR | true | Field of study | |
| study_school | VARCHAR | true | School/University | |
| emergency_contact | VARCHAR | true | Emergency contact name | PII |
| emergency_phone | VARCHAR | true | Emergency contact phone | PII |
| distance_home_work_unit | VARCHAR | false | Unit for distance | |
| employee_type | VARCHAR | false | Type (e.g., employee, trainee) | |
| barcode | VARCHAR | true | Badge barcode | |
| pin | VARCHAR | true | Security PIN | Sensitive |
| private_car_plate | VARCHAR | true | Car license plate | PII |
| spouse_birthdate | DATE | true | Spouse birth date | PII |
| birthday | DATE | true | Employee birth date | PII |
| visa_expire | DATE | true | Visa expiration date | |
| work_permit_expiration_date | DATE | true | Permit expiration date | |
| departure_date | DATE | true | Date of departure | |
| employee_properties | JSONB | true | Dynamic attributes | |
| additional_note | TEXT | true | Additional notes | |
| notes | TEXT | true | General notes | |
| departure_description | TEXT | true | Reason for departure | |
| active | BOOLEAN | true | Soft-delete flag | |
| is_flexible | BOOLEAN | true | Flexible work flag | |
| is_fully_flexible | BOOLEAN | true | Fully flexible flag | |
| work_permit_scheduled_activity | BOOLEAN | true | Permit activity flag | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Last update timestamp | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `department_id` → `hr_department.id` (Guess: links to organizational unit)
    - `job_id` → `hr_job.id` (Guess: links to job position definition)
    - `parent_id` → `hr_employee.id` (Guess: self-reference for reporting line)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
- **Natural keys (inferred):** 
    - `work_email` (Commonly unique in Odoo)
    - `ssnid` / `identification_id` (Often used as business unique identifiers)

## Caveats for downstream consumers

- **Sensitive Data:** This table contains significant PII (SSN, home addresses, private phones, emergency contacts, passport numbers). Ensure strict access control and masking policies.
- **Timestamps:** `create_date` and `write_date` are stored in UTC, consistent with Odoo's internal handling.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical/terminated records are required.
- **JSONB:** The `employee_properties` column contains unstructured data; use `->>` or `jsonb_extract_path_text` to query specific attributes.