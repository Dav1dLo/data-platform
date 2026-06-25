# crm_recurring_plan

## Source system
The table likely originates from an Odoo ERP or a similar modular CRM/ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for the `name` field and sequence-based primary keys, is highly characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the subscription or recurring billing management process. It defines the duration and sequencing logic for recurring plans, allowing the business to configure how long a subscription cycle lasts (`number_of_months`) and the order in which these plans are presented or processed (`sequence`).

## Description
One row in this table represents a single configuration definition for a recurring billing plan. It serves as a raw landed copy of the plan metadata, capturing the duration, active status, and audit trail for each plan defined within the CRM system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| number_of_months | INTEGER | false | Duration of the plan in months | Defines the billing cycle length. |
| sequence | INTEGER | true | Display or processing order | Used for sorting plans in the UI. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| name | JSONB | false | Plan name or label | Likely contains multi-language strings. |
| active | BOOLEAN | true | Soft-delete flag | True if the plan is currently available. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = true` to retrieve only current, valid plans.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **JSONB:** The `name` column contains structured data; use PostgreSQL JSONB operators (e.g., `->>`) to extract text values for reporting.
- **Sensitive Data:** No direct PII is present, but `create_uid` and `write_uid` link to internal user identities.