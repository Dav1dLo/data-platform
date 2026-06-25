# onboarding_onboarding

## Source system
The table likely originates from an Odoo ERP instance, indicated by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework. The use of `JSONB` for the `name` column is also characteristic of modern PostgreSQL-backed Odoo deployments.

## Functional process 
This table supports the user interface onboarding or "guided tour" configuration process. It tracks the sequence and naming of specific onboarding steps or panels within the application, allowing the system to manage the state and progression of user-facing instructional flows.

## Description
One row in this table represents a single configuration entry for an onboarding panel or step within the application. As a staging table, it serves as a raw, direct copy of the source system's onboarding definition records, maintaining the grain of one row per defined onboarding step.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.onboarding_onboarding_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort the order of onboarding steps. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system's user table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system's user table. |
| route_name | VARCHAR | false | Internal route identifier | The unique path or action name for the onboarding step. |
| text_completed | VARCHAR | true | Completion text | The message displayed when the step is finished. |
| panel_close_action_name | VARCHAR | true | Close action identifier | The name of the action triggered when the panel is closed. |
| name | JSONB | true | Localized display name | Stores the name of the onboarding step, likely in multiple languages. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field pattern).
- **Natural keys (inferred):** 
    - `route_name` (Likely acts as the business identifier for the onboarding step).

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII is evident, though `name` (JSONB) may contain internal configuration strings.
- **Timestamps:** Timestamps are assumed to be in UTC as per standard Odoo/PostgreSQL practices, but verify against the source system's timezone settings.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are current unless otherwise specified by the source system logic.
- **JSONB:** The `name` column requires PostgreSQL JSONB operators (e.g., `->>`) to extract specific language values.