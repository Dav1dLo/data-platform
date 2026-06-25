# mail_resend_partner

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`mail_resend_partner_id_seq`), the use of `create_uid`/`write_uid` audit columns, and the `_id` suffix pattern common to Odoo's PostgreSQL-backed ORM.

## Functional process 
This table supports the email communication and notification retry process. It tracks which specific partners (recipients) are associated with a failed email notification that is being processed for resending via a wizard interface, allowing the system to manage individual delivery statuses during bulk retry operations.

## Description
One row represents a single recipient's association with a specific email notification retry event. This is a raw landing table in the staging layer, capturing the state of the `mail.resend.partner` model from the source ERP to facilitate audit and troubleshooting of failed outgoing communications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mail_resend_partner_id_seq`. |
| notification_id | INTEGER | false | Foreign key to the notification | Links to the parent email notification record. |
| resend_wizard_id | INTEGER | true | Foreign key to the resend wizard | Links to the specific wizard session triggering the retry. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the record creation. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| message | VARCHAR | true | Error or status message | Contains details regarding the delivery failure or retry status. |
| resend | BOOLEAN | true | Resend flag | Indicates if this specific partner is marked for a retry attempt. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in the source system's local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in the source system's local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `notification_id` → `mail_notification.id` (Guess: links to the core notification record being retried).
    - `resend_wizard_id` → `mail_resend_wizard.id` (Guess: links to the transient wizard model managing the retry process).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `message` column may contain PII or internal system error details; handle with appropriate access controls.
- **Timezone:** Timestamps (`create_date`, `write_date`) are stored in the source system's local time; verify if the source ERP is configured for UTC.
- **Data Retention:** This table reflects the state of the Odoo model; it does not explicitly indicate if records are purged after the retry wizard completes.
- **Nullability:** Many fields are nullable, suggesting that not all retry attempts require a wizard session or have associated error messages.