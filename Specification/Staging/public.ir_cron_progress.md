# ir_cron_progress

## Source system
This table originates from an Odoo ERP environment. The naming convention `ir_cron` is characteristic of Odoo's internal registry (`ir`) for scheduled actions (`cron`), which manages background task execution and progress tracking.

## Functional process 
This table supports the background task management and automation process. It tracks the execution state of scheduled jobs, specifically monitoring progress metrics like remaining work units and completion counts to ensure long-running background processes are monitored and can handle timeouts.

## Description
One row in this table represents the current execution progress and status of a specific scheduled background task. It serves as a raw landing record in the staging layer, capturing the state of cron jobs at the grain of one row per cron task identifier.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_cron_progress_id_seq`. |
| cron_id | INTEGER | false | Foreign key to the cron definition | Links to the specific scheduled action being tracked. |
| remaining | INTEGER | true | Count of items left to process | Represents work pending for the task. |
| done | INTEGER | true | Count of items completed | Represents work finished by the task. |
| timed_out_counter | INTEGER | true | Number of timeout occurrences | Tracks how many times the task has hit a timeout limit. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the tracking record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| deactivate | BOOLEAN | true | Deactivation flag | Indicates if the progress tracking is disabled. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was first created. |
| write_date | TIMESTAMP | true | Last modification timestamp | Timestamp when the record was last updated. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `cron_id` → `ir_cron.id`: This column references the primary definition of the scheduled action.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking the user who created a record.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking the user who last modified a record.
- **Natural keys (inferred):** 
    - `cron_id`: In the context of progress tracking, the cron identifier acts as the business key for the task state.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the database server's local time (typically UTC in Odoo deployments), but verify against the application server configuration.
- **Data Sensitivity:** Contains `create_uid` and `write_uid`, which link to user records; ensure appropriate access controls are applied to user metadata.
- **Soft Deletes:** This table does not appear to implement a standard soft-delete flag; the `deactivate` boolean is specific to the cron progress logic, not necessarily record deletion.
- **Grain:** This is a state-tracking table; expect frequent updates to `remaining`, `done`, and `write_date` as background tasks progress.