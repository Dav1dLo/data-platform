# project_task_recurrence

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` is a signature pattern for Odoo's ORM-based database schema.

## Functional process 
This table supports the task management and scheduling module, specifically handling the logic for recurring project tasks. It defines the frequency and duration rules for tasks that repeat over time, which are then linked to specific task definitions to automate the creation of follow-up work items.

## Description
One row in this table represents a single recurrence configuration rule for a project task. It acts as a raw staging entity, capturing the parameters (interval, unit, type, and end date) that dictate how and when a task should repeat.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `project_task_recurrence_id_seq`. |
| repeat_interval | INTEGER | true | Frequency multiplier | e.g., "2" in "every 2 weeks". |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the users table. |
| repeat_unit | VARCHAR | true | Time unit for recurrence | e.g., 'day', 'week', 'month'. |
| repeat_type | VARCHAR | true | Recurrence strategy | e.g., 'forever', 'until', 'count'. |
| repeat_until | DATE | true | End date for the recurrence | Only applicable if `repeat_type` is 'until'. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** As a staging table, this may contain orphaned records or incomplete configurations if the upstream process was interrupted.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted_at` flag; assume all records are current unless otherwise specified by business logic.
- **Nullability:** Many fields (like `repeat_interval` or `repeat_until`) are nullable because they depend on the specific `repeat_type` selected. Ensure your queries handle `NULL` values when calculating recurrence schedules.