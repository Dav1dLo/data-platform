# onboarding_progress_step

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a standard pattern for Odoo's ORM-managed tables, which track record creation and modification metadata automatically.

## Functional process 
This table supports the customer onboarding or implementation pipeline. It tracks the completion status of specific configuration or setup tasks (represented by `step_id`) associated with a specific client entity (`company_id`), allowing the system to monitor progress through a multi-stage onboarding workflow.

## Description
One row represents the current state of a specific onboarding step for a particular company. This is a raw landing table in the staging layer, containing a snapshot of the application's internal progress tracking state.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `onboarding_progress_step_id_seq`. |
| step_id | INTEGER | false | Identifier for the specific onboarding task | Likely references a master list of onboarding steps. |
| company_id | INTEGER | true | Identifier for the company undergoing onboarding | Foreign key to the company/tenant table. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| step_state | VARCHAR | true | Current status of the step | e.g., 'pending', 'in_progress', 'completed'. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (guess: standard Odoo naming convention for company links).
    - `create_uid` / `write_uid` → `res_users.id` (guess: standard Odoo naming convention for user audit trails).
- **Natural keys (inferred):** 
    - `(company_id, step_id)`: The combination of company and step likely represents the unique business grain.

## Caveats for downstream consumers

- **PII/Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined to a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC; verify against system configuration if precision is required for audit logs.
- **Data Integrity:** As a staging table, this may contain duplicates or partial updates if the ingestion process is not idempotent.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag; assume all rows are current unless filtered by business logic.