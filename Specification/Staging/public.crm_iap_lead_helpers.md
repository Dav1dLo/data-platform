# crm_iap_lead_helpers

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework that utilizes the `create_uid` and `write_uid` naming convention for audit tracking. The "iap" prefix suggests integration with an "In-App Purchasing" or "Internal Application Platform" service module within that ecosystem.

## Functional process 
This table supports the lead management and CRM automation pipeline, specifically tracking metadata for helper records associated with lead generation or enrichment processes. It serves as an audit and lifecycle tracking table for internal helper entities.

## Description
One row represents a single helper record associated with a CRM lead process, capturing the identity of the users who created or modified the record and the corresponding timestamps. As a staging table, it provides a raw, landed copy of the source system's audit metadata for these helper entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | User ID of the creator | References the system's internal user table. |
| write_uid | INTEGER | true | User ID of the last modifier | References the system's internal user table. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo-style user reference).
    - `write_uid` → `res_users.id` (guess: standard Odoo-style user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC; verify against source system configuration if precision is required for cross-timezone reporting.
- **Audit fields:** `create_uid` and `write_uid` are likely foreign keys to a user management table not present in this schema.
- **Soft deletes:** This table does not explicitly show a boolean `active` or `deleted` flag; assume all rows are currently active unless otherwise specified by business logic.
- **Data Sensitivity:** Contains user IDs which may be linked to PII in the source system; ensure appropriate access controls are applied.