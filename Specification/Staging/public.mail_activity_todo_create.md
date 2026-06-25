# mail_activity_todo_create

## Source system
This table originates from an Odoo ERP system. The naming convention `mail_activity_todo_create` combined with standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `nextval` sequences for primary keys is characteristic of the Odoo framework's internal data storage.

## Functional process 
This table supports the "Activity Management" or "Task Tracking" business process within the CRM or Project modules. It tracks individual to-do items or follow-up activities assigned to users, capturing the deadline, descriptive summary, and detailed notes associated with each task.

## Description
One row in this table represents a single to-do activity or task created within the system. It serves as a raw landing copy of activity records, capturing the state of a task at the grain of one row per activity instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_activity_todo_create_id_seq`. |
| user_id | INTEGER | false | Assigned user ID | Foreign key to the system's user table. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| summary | VARCHAR | true | Activity summary | Short description or title of the task. |
| date_deadline | DATE | false | Due date | The date by which the activity should be completed. |
| note | TEXT | true | Detailed notes | Free-text field for additional task context. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone usually UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone usually UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Likely reference to the system users table).
    - `create_uid` → `res_users.id` (Likely reference to the system users table).
    - `write_uid` → `res_users.id` (Likely reference to the system users table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `note` column may contain unstructured PII or internal communications; ensure appropriate masking if exposed to non-authorized roles.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are current unless otherwise specified by business logic.
- **Data Quality:** `create_uid` and `write_uid` may be null for legacy records or system-generated entries.