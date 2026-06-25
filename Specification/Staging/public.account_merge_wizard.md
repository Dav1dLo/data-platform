# account_merge_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the customer data management process, specifically the "Merge Accounts" utility. It tracks the state and configuration of wizard sessions used to identify and consolidate duplicate account records within the CRM or Sales modules.

## Description
One row represents a single execution instance or configuration session of an account merge wizard. It acts as a staging record for the parameters and audit trail of a merge operation, capturing who initiated the process and when it was last modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_merge_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| is_group_by_name | BOOLEAN | true | Flag for merge logic | Indicates if the wizard is grouping potential duplicates by name. |
| create_date | TIMESTAMP | true | Record creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit fields:** `create_uid` and `write_uid` are internal Odoo user IDs; they will not resolve to meaningful names without joining to the `res_users` table.
- **Data Lifecycle:** This is a staging table for a wizard process; records may be transient or represent short-lived sessions rather than permanent business entities.
- **Sensitive Data:** No PII is directly present, but the table tracks administrative actions performed by specific users.