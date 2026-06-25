# onboarding_progress

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. This is evidenced by the specific naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields used by the Odoo ORM to track record creation and modification.

## Functional process 
This table supports the customer onboarding lifecycle management process. It tracks the status and progression of onboarding workflows associated with specific companies, allowing the system to monitor whether an onboarding process is active, in progress, or closed.

## Description
One row in this table represents the current progress state of a specific onboarding workflow for a given company. It serves as a raw landed copy of the onboarding status, capturing audit metadata and state flags to facilitate reporting on implementation velocity and completion rates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `onboarding_progress_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company entity | Identifies the organization undergoing onboarding. |
| onboarding_id | INTEGER | false | Identifier for the onboarding workflow | Links to the specific onboarding template or process definition. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the internal user table. |
| onboarding_state | VARCHAR | true | Current status of the onboarding | e.g., 'started', 'in_progress', 'completed'. |
| is_onboarding_closed | BOOLEAN | true | Completion flag | Indicates if the onboarding process is finalized. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (guess: standard Odoo naming convention for company links).
    - `create_uid` → `res_users.id` (guess: standard Odoo naming convention for user audit fields).
    - `write_uid` → `res_users.id` (guess: standard Odoo naming convention for user audit fields).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard PostgreSQL/Odoo practices.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag; assume all rows are active unless otherwise specified by business logic.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal system user IDs; ensure joins are performed against the appropriate user dimension table if mapping to human-readable names.
- **Data Quality:** `company_id` is nullable, which may indicate orphaned records or system-level onboarding processes not tied to a specific company.