# ir_cron_trigger

## Source system
This table originates from an Odoo ERP system, as indicated by the `ir_cron_trigger` naming convention, which is a standard internal table used by the Odoo framework to manage scheduled action triggers.

## Functional process 
This table supports the background job scheduling and automation process. It tracks specific instances where a scheduled action (cron job) is queued to be executed at a future time, ensuring that the system can process deferred tasks asynchronously.

## Description
One row in this table represents a single pending execution trigger for a scheduled task. It serves as a staging record that links a specific cron job definition to a precise execution timestamp, allowing the system to track and process background operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique surrogate primary key | Uses sequence `ir_cron_trigger_id_seq`. |
| cron_id | INTEGER | true | Foreign key to the cron job definition | Links to the parent scheduled action. |
| create_uid | INTEGER | true | ID of the user who created the trigger | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the trigger | References `res_users`. |
| call_at | TIMESTAMP | true | Scheduled execution time | The timestamp when the job is intended to run. |
| create_date | TIMESTAMP | true | Record creation timestamp | Typically in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Typically in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `cron_id` → `ir_cron.id`: This column links the trigger to the specific scheduled action definition.
    - `create_uid` → `res_users.id`: Tracks the system user responsible for the trigger creation.
    - `write_uid` → `res_users.id`: Tracks the system user responsible for the last update.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`call_at`, `create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table is highly volatile; rows are typically deleted or marked as processed once the associated cron job executes.
- No PII is explicitly contained in this table, though `create_uid` and `write_uid` link to user identity records.