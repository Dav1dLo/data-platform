# calendar_alarm

## Source system
This table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`, `JSONB` for translatable fields) and the specific structure of alarm configurations are characteristic of the Odoo framework's internal calendar and notification modules.

## Functional process 
This table supports the calendar notification and reminder system. It defines the parameters for how and when users are alerted regarding scheduled events, managing the association between time intervals, notification methods (email/SMS), and the content templates used for these alerts.

## Description
Each row represents a specific alarm configuration used to trigger reminders for calendar events. The table acts as a raw landing copy of the system's alarm definitions, capturing the duration, notification type, and associated communication templates. It is maintained at the grain of one unique alarm definition per row.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| duration | INTEGER | false | Numeric value of the alarm offset | Used in conjunction with the interval column. |
| duration_minutes | INTEGER | true | Calculated duration in minutes | Denormalized helper field for easier filtering. |
| mail_template_id | INTEGER | true | Foreign key to email template | Links to the email notification definition. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the alarm. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the alarm. |
| alarm_type | VARCHAR | false | Type of notification | e.g., 'email', 'sms', 'notification'. |
| interval | VARCHAR | false | Time unit for duration | e.g., 'minutes', 'hours', 'days'. |
| name | JSONB | false | Display name of the alarm | Likely contains multi-language support. |
| body | TEXT | true | Optional message content | Custom text body for the notification. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the system. |
| sms_template_id | INTEGER | true | Foreign key to SMS template | Links to the SMS notification definition. |
| sms_notify_responsible | BOOLEAN | true | SMS notification flag | Indicates if the responsible party should be notified via SMS. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id` (Guess: standard Odoo naming for email templates).
    - `sms_template_id` → `sms_template.id` (Guess: standard Odoo naming for SMS templates).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **JSONB:** The `name` column is stored as `JSONB`; downstream SQL queries may require the `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Data Integrity:** As a staging table, this may contain system-generated records that are not exposed in the application UI; verify if `id` sequences match the production environment.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), so assume all records present are currently active unless otherwise specified by business logic.