# ir_actions_todo

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_actions_todo` (where `ir` stands for "Internal Resources") and the presence of standard Odoo audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date` are characteristic of the Odoo framework's metadata management.

## Functional process 
This table supports the "Action Todo" or "Server Action" management process within the ERP. It tracks pending tasks or automated actions that the system needs to execute, often used for workflow automation, scheduled tasks, or user-specific action queues.

## Description
One row in this table represents a single "To-Do" action item or task definition within the system. It acts as a raw landed copy of the Odoo internal action registry, capturing the state and sequencing of tasks that require processing or user attention.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `ir_actions_todo_id_seq`. |
| action_id | INTEGER | false | Reference to the specific action definition | Likely links to an `ir_actions` table. |
| sequence | INTEGER | true | Execution order priority | Lower numbers typically indicate higher priority. |
| create_uid | INTEGER | true | ID of the user who created the record | Links to `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Links to `res_users.id`. |
| state | VARCHAR | false | Current status of the action | e.g., 'open', 'done', 'cancelled'. |
| name | VARCHAR | true | Descriptive name of the action | Human-readable label. |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed. |
| write_date | TIMESTAMP | true | Timestamp of last record update | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `action_id` → `ir_actions.id` (Guess: standard Odoo pattern for linking action definitions).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `state` column is critical for filtering; ensure you understand the business logic of the specific state values (e.g., only process 'open' items).
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit metadata (`create_uid`, `write_uid`) which may be useful for tracking administrative changes to task definitions.
- No explicit soft-delete flag is present; assume records are either active or represent a historical log of actions.