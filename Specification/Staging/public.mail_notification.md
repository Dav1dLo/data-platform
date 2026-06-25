# mail_notification

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns like `mail_message_id`, `res_partner_id`, and the use of Odoo-specific sequence generators (`mail_notification_id_seq`).

## Functional process 
This table supports the internal communication and notification tracking process. It tracks the delivery status and read receipts of messages (emails, SMS, or physical letters) sent to partners within the ERP, linking specific message instances to the recipients and recording any delivery failures.

## Description
One row in this table represents a single notification event for a specific recipient regarding a mail message. It serves as a raw landing copy of the notification state, capturing the delivery status, read timestamps, and failure details for communications managed by the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mail_notification_id_seq`. |
| author_id | INTEGER | true | ID of the user who authored the notification | Likely references `res_users`. |
| mail_message_id | INTEGER | false | ID of the parent message | References `mail_message`. |
| mail_mail_id | INTEGER | true | ID of the specific email record | References `mail_mail`. |
| res_partner_id | INTEGER | true | ID of the recipient partner | References `res_partner`. |
| notification_type | VARCHAR | false | Type of notification (e.g., email, inbox, sms) | Categorical field. |
| notification_status | VARCHAR | true | Current delivery status | e.g., 'ready', 'sent', 'exception', 'canceled'. |
| failure_type | VARCHAR | true | Categorized reason for delivery failure | e.g., 'bounce', 'smtp'. |
| failure_reason | TEXT | true | Detailed error message for delivery failure | Contains raw error logs. |
| is_read | BOOLEAN | true | Read status flag | True if the recipient has opened/read the notification. |
| read_date | TIMESTAMP | true | Timestamp when the notification was read | Assumed UTC. |
| sms_id_int | INTEGER | true | ID of the associated SMS record | References `sms_sms`. |
| sms_number | VARCHAR | true | Phone number used for SMS delivery | May contain PII. |
| letter_id | INTEGER | true | ID of the associated physical letter record | References `mail_mail_letter`. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id` (Evidence: naming convention matches Odoo standard message tables).
    - `res_partner_id` → `res_partner.id` (Evidence: standard Odoo naming for partner references).
    - `mail_mail_id` → `mail_mail.id` (Evidence: standard Odoo naming for email objects).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII:** The `sms_number` column contains contact information and should be handled according to data privacy policies.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** This is a staging table; `notification_status` and `failure_reason` may be updated frequently by background workers, so point-in-time analysis should account for potential race conditions.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically deleted if removed from the source.