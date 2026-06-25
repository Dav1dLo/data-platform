# mail_scheduled_message

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `res_id`, `create_uid`, `write_uid`, `model`) and the use of PostgreSQL sequences for primary keys are characteristic of Odoo's ORM layer.

## Functional process 
This table supports the automated communication and notification engine within the ERP. It manages the queue of messages or emails that are scheduled to be sent at a future time, linking them to specific business objects (e.g., invoices, tasks, or CRM leads) via the `model` and `res_id` columns.

## Description
Each row represents a single scheduled message or notification record waiting to be processed by the system's mail scheduler. This is a raw staging table containing the metadata, content, and scheduling details for outgoing communications. It serves as the landing point for pending system notifications before they are dispatched.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_scheduled_message_id_seq`. |
| res_id | INTEGER | false | Related business object ID | The ID of the record in the table defined by `model`. |
| author_id | INTEGER | false | Author user ID | References the user who created the message. |
| create_uid | INTEGER | true | Creator user ID | The user who initially created the record. |
| write_uid | INTEGER | true | Last modifier user ID | The user who last updated the record. |
| subject | VARCHAR | true | Email subject line | The text displayed as the subject of the message. |
| model | VARCHAR | false | Related business model | The technical name of the Odoo model (e.g., 'crm.lead'). |
| body | TEXT | true | Message content | The HTML or plain text body of the message. |
| notification_parameters | TEXT | true | Notification settings | JSON or serialized parameters for the notification engine. |
| is_note | BOOLEAN | true | Note flag | Indicates if the message is an internal note vs. an email. |
| scheduled_date | TIMESTAMP | false | Execution timestamp | The date and time the message is scheduled to be sent. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp when the record was inserted. |
| write_date | TIMESTAMP | true | Record modification timestamp | Timestamp when the record was last updated. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `author_id` → `res_users.id` (Guess: Standard Odoo pattern for user references).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` and `subject` columns may contain PII or sensitive business communication; ensure appropriate masking if exposing to non-privileged users.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against system configuration if local time conversion is required.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume rows are removed upon processing or deletion.
- **Model Polymorphism:** The `res_id` column is polymorphic; it must be joined against the table specified in the `model` column, which cannot be done via standard static SQL joins.