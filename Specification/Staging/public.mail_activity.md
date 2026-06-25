# mail_activity

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `res_model`, `create_uid`, `write_uid`, `res_id`) and the specific structure of activity tracking are characteristic of the Odoo framework's internal ORM layer.

## Functional process 
This table supports the CRM and communication management process by tracking scheduled tasks, follow-ups, and interactions related to specific business records. It manages the lifecycle of activities—such as calls, meetings, or emails—linked to entities like leads, opportunities, or partners, facilitating the "Lead-to-cash" and customer engagement pipelines.

## Description
One row represents a single scheduled or completed activity instance associated with a specific business record. It acts as a raw landing copy of the Odoo `mail.activity` model, capturing the metadata, deadlines, and status of tasks assigned to users within the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| res_model_id | INTEGER | false | ID of the related model | References the model definition. |
| res_id | INTEGER | true | ID of the related record | Foreign key to the target business object. |
| activity_type_id | INTEGER | true | Type of activity | References `mail.activity.type`. |
| user_id | INTEGER | false | Assigned user ID | The user responsible for the activity. |
| request_partner_id | INTEGER | true | Requesting partner ID | The partner who initiated the request. |
| recommended_activity_type_id | INTEGER | true | Suggested next activity type | Used for activity chaining. |
| previous_activity_type_id | INTEGER | true | Previous activity type | Used for activity history tracking. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| res_model | VARCHAR | true | Model name | Technical name of the related model (e.g., 'crm.lead'). |
| res_name | VARCHAR | true | Display name of the record | Denormalized name of the target record. |
| summary | VARCHAR | true | Activity summary | Short description of the task. |
| user_tz | VARCHAR | true | User timezone | Timezone string (e.g., 'UTC'). |
| date_deadline | DATE | false | Deadline date | The date by which the activity should be done. |
| date_done | DATE | true | Completion date | The date the activity was marked as finished. |
| note | TEXT | true | Detailed notes | Free-text field for activity details. |
| automated | BOOLEAN | true | Automation flag | Indicates if the activity was system-generated. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the record is currently active. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp. |
| calendar_event_id | INTEGER | true | Related calendar event ID | Link to `calendar.event` if applicable. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (User responsible for the activity)
    - `activity_type_id` → `mail_activity_type.id` (Type definition for the activity)
    - `calendar_event_id` → `calendar_event.id` (Link to a scheduled meeting)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `note` and `summary` fields may contain PII or internal communication details; ensure appropriate masking if exposing to non-authorized users.
- **Timezones:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo, but `user_tz` is provided as a reference for local display.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing historical analysis.
- **Denormalization:** `res_name` is a denormalized field and may not always be perfectly in sync with the source record. Always prefer joining on `res_id` and `res_model` to fetch current data.