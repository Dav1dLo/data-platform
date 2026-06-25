# crm_lead_pls_update

## Source system
The table likely originates from an Odoo ERP or CRM system, indicated by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework.

## Functional process 
This table supports the Predictive Lead Scoring (PLS) process within the CRM. It tracks the temporal configuration or status updates for lead scoring models, specifically identifying when a scoring period begins (`pls_start_date`) and which users performed the record creation or modification.

## Description
One row in this table represents a specific update or configuration event for a predictive lead scoring record. It serves as a raw landed staging table, capturing the audit trail and start-date parameters for lead scoring logic within the CRM.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead_pls_update_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| pls_start_date | DATE | false | Start date for the lead scoring period | Defines the effective date of the scoring logic. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- The table does not explicitly show a soft-delete flag; assume all records are active unless a separate status column is introduced in future schema versions.
- `create_uid` and `write_uid` may be null if the record was created via a system process or automated migration script rather than a specific user action.