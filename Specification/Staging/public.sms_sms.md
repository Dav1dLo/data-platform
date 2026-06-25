# sms_sms

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `partner_id`, `mail_message_id`, `create_uid`, `write_uid`) and the specific sequence-based primary key pattern are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the SMS communication module within the ERP, handling the lifecycle of outgoing text messages. It tracks the association between SMS records and business entities (partners), links to internal messaging threads (`mail_message_id`), and manages the delivery state and failure reporting for automated notifications or manual communications.

## Description
One row represents a single SMS message record managed by the system. It captures the message content, the recipient's phone number, the current delivery status, and audit timestamps. As a staging table, it serves as a raw, landed copy of the Odoo `sms.sms` model, preserving the system's internal state and metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_sms_id_seq` sequence. |
| partner_id | INTEGER | true | Foreign key to the recipient partner | Links to the `res.partner` table. |
| mail_message_id | INTEGER | true | Foreign key to the mail message | Links to the `mail.message` table. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the record | Links to `res.users`. |
| uuid | VARCHAR | true | Unique identifier for the SMS | Often used for external API tracking. |
| number | VARCHAR | true | Recipient phone number | May contain international formatting. |
| state | VARCHAR | false | Current delivery status | e.g., 'outgoing', 'sent', 'error', 'canceled'. |
| failure_type | VARCHAR | true | Reason for delivery failure | Populated only if state is 'error'. |
| body | TEXT | true | The content of the SMS | The actual text message sent. |
| to_delete | BOOLEAN | true | Soft-delete flag | Indicates if the record is marked for removal. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Inferred from Odoo naming convention).
    - `mail_message_id` → `mail_message.id` (Inferred from Odoo naming convention).
    - `create_uid` → `res_users.id` (Inferred from Odoo naming convention).
    - `write_uid` → `res_users.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** `uuid` (likely acts as the business-level unique identifier for the SMS transaction).

## Caveats for downstream consumers

- **Sensitive Data:** The `number` and `body` columns contain PII and message content; ensure appropriate masking for non-privileged users.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `to_delete` column suggests a soft-delete mechanism; queries should filter by `WHERE to_delete IS NOT TRUE` to exclude records marked for removal.
- **State Logic:** The `state` column is the primary driver for reporting; ensure all statuses are accounted for when calculating delivery success rates.