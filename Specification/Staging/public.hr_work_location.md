# hr_work_location

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the Human Resources and organizational structure management process. It defines the physical or logical work locations associated with a company, likely used for payroll tax nexus, site-specific reporting, or employee assignment tracking within the HR module.

## Description
One row in this table represents a single work location entity associated with a specific company. This is a raw landing table in the staging layer, containing a direct copy of the source system's location records, including audit metadata and status flags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `hr_work_location_id_seq`. |
| company_id | INTEGER | false | Foreign key to the owning company | Links to the company entity. |
| address_id | INTEGER | false | Foreign key to the address record | Links to a separate address/partner table. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| name | VARCHAR | false | Descriptive name of the location | e.g., "Headquarters", "Warehouse A". |
| location_type | VARCHAR | false | Categorization of the location | Defines the nature of the work site. |
| location_number | VARCHAR | true | Internal or external location code | Often used for regulatory or payroll reporting. |
| active | BOOLEAN | true | Soft-delete status flag | True if the location is currently in use. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Inferred from standard Odoo naming patterns).
    - `address_id` → `res_partner.id` (Inferred from standard Odoo naming patterns).
    - `create_uid` → `res_users.id` (Inferred from standard Odoo naming patterns).
    - `write_uid` → `res_users.id` (Inferred from standard Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless historical analysis is required.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the source system allows for transient states during synchronization.
- **Sensitivity:** No direct PII (like names or emails) is present, but the table links to address and user records which may be sensitive.