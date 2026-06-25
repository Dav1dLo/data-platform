# ir_cron

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_cron` is a standard Odoo internal table used to manage scheduled actions (cron jobs) within the framework's "ir" (Internal Resources) module.

## Functional process 
This table supports the background task scheduling and automation engine of the platform. It manages the execution frequency, priority, and status of automated system processes, such as email queue processing, report generation, or data synchronization tasks, by tracking when they were last run and when they are next scheduled to execute.

## Description
One row in this table represents a single scheduled background task or "cron job" configuration. It acts as a raw landed copy of the system's task scheduler settings, capturing the timing, ownership, and execution history for each automated process defined within the application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_cron_id_seq`. |
| ir_actions_server_id | INTEGER | false | Foreign key to server actions | Links to the specific action to be executed. |
| user_id | INTEGER | false | Execution user ID | The system user context under which the job runs. |
| interval_number | INTEGER | false | Frequency interval | Numeric value for the recurrence period. |
| priority | INTEGER | true | Execution priority | Lower numbers typically indicate higher priority. |
| failure_count | INTEGER | true | Error counter | Tracks consecutive failures for the task. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the cron job. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the job. |
| cron_name | VARCHAR | true | Job display name | Human-readable label for the scheduled task. |
| interval_type | VARCHAR | false | Time unit | e.g., 'minutes', 'hours', 'days', 'months'. |
| active | BOOLEAN | true | Status flag | Indicates if the scheduled task is currently enabled. |
| nextcall | TIMESTAMP | false | Next execution time | Scheduled timestamp for the next run. |
| lastcall | TIMESTAMP | true | Last execution time | Timestamp of the most recent successful run. |
| first_failure_date | TIMESTAMP | true | Initial failure timestamp | Timestamp of the first error in a failure sequence. |
| create_date | TIMESTAMP | true | Record creation date | Audit timestamp for record creation. |
| write_date | TIMESTAMP | true | Record update date | Audit timestamp for last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_actions_server_id` → `ir_actions_server.id` (Likely target based on Odoo schema conventions).
    - `user_id` → `res_users.id` (Standard Odoo pattern for user ownership).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Active Status:** Queries should generally filter by `active = TRUE` to avoid including disabled or legacy scheduled tasks.
- **Sensitive Data:** While this table does not contain PII, the `user_id` column links to system users, which may be sensitive in some security contexts.
- **Soft Deletes:** Odoo often uses the `active` flag for soft deletes; ensure your queries account for this column to avoid retrieving inactive configurations.