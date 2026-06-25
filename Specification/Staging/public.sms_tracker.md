# sms_tracker

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the tracking and audit logging of SMS communications sent via the platform. It acts as a bridge between notification events and the underlying SMS delivery system, likely used to monitor the status and lifecycle of outgoing text messages triggered by business workflows.

## Description
One row represents a single SMS communication event or tracking record within the system. This is a raw staging table containing metadata about the creation and modification of SMS records, serving as a landing point for downstream reporting on communication volume and delivery status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_tracker_id_seq` sequence. |
| mail_notification_id | INTEGER | true | Foreign key to the related mail notification | Links the SMS to a specific email/notification event. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| sms_uuid | VARCHAR | false | Unique identifier for the SMS | Likely the business-level unique key for the message. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_notification_id` → `mail_notification.id` (Guess: links to a parent notification record).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** 
    - `sms_uuid`

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume all records are active unless otherwise specified by business logic.
- **PII:** While this table does not contain message content, it links to user IDs and notification IDs which may be used to join against tables containing sensitive communication data.