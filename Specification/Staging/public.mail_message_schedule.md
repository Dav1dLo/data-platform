# mail_message_schedule

## Source system
This table originates from an Odoo ERP system. The naming convention (`mail_message_id`, `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of Postgres sequences for primary keys are characteristic of Odoo's internal ORM structure for managing scheduled email communications.

## Functional process 
This table supports the automated communication and notification pipeline. It tracks the scheduling of specific email messages, storing the intended delivery time and associated notification parameters required by the mail server to process the message queue.

## Description
One row in this table represents a single scheduled instance of an email message, defining when it is queued to be sent. As a staging table, it serves as a raw, direct copy of the Odoo operational database, capturing the state of pending or historical message schedules at the grain of one row per scheduled message event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_message_schedule_id_seq` |
| mail_message_id | INTEGER | false | Foreign key to the parent message | Links to the core mail message entity |
| create_uid | INTEGER | true | User ID who created the schedule | References the system user table |
| write_uid | INTEGER | true | User ID who last updated the schedule | References the system user table |
| notification_parameters | TEXT | true | JSON or serialized config for delivery | Likely contains SMTP or routing metadata |
| scheduled_datetime | TIMESTAMP | false | Intended delivery timestamp | The time the system attempts to send |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC |
| write_date | TIMESTAMP | true | Last record update timestamp | In UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: This column links the schedule to the specific message content being sent.
    - `create_uid` → `res_users.id`: This column tracks the system user responsible for the record creation.
    - `write_uid` → `res_users.id`: This column tracks the system user responsible for the last modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`create_date`, `write_date`, `scheduled_datetime`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** The `notification_parameters` column may contain sensitive configuration data, such as API keys, specific routing tokens, or internal system paths; handle with appropriate masking.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` or `is_deleted`); assume rows are removed physically if they disappear from the source.
- **Integrity:** As a staging table, ensure that joins to `mail_message` account for potential missing records if the extraction process is not perfectly synchronized.