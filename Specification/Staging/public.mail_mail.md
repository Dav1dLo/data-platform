# mail_mail

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `mail_mail`, `mail_message_id`, `create_uid`) and the specific sequence-based primary key pattern are characteristic of the Odoo framework's messaging and notification module.

## Functional process 
This table supports the outbound email delivery process within the Odoo messaging system. It acts as a queue or log for emails that have been generated from system messages and are either pending, sent, or failed, facilitating the "Communication and Notification" business process.

## Description
One row represents a single outbound email transmission attempt associated with a system message. This table serves as a raw landed copy of the Odoo `mail.mail` model, capturing the state, recipient details, and delivery metadata for emails processed by the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_mail_id_seq` sequence. |
| mail_message_id | INTEGER | false | Foreign key to the parent message | Links to the `mail.message` table. |
| fetchmail_server_id | INTEGER | true | ID of the incoming mail server | Used if the email is a reply or linked to an incoming server. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users`. |
| email_cc | VARCHAR | true | Carbon copy email addresses | Often contains multiple addresses. |
| state | VARCHAR | true | Current delivery status | e.g., 'outgoing', 'sent', 'exception', 'cancel'. |
| failure_type | VARCHAR | true | Categorization of delivery failure | Used for programmatic handling of bounces. |
| body_html | TEXT | true | The HTML content of the email | Contains the rendered email body. |
| references | TEXT | true | Email message-id references | Used for threading email conversations. |
| headers | TEXT | true | Raw email headers | JSON or text block of SMTP headers. |
| email_to | TEXT | true | Recipient email addresses | Comma-separated list of primary recipients. |
| failure_reason | TEXT | true | Detailed error message | Populated if state is 'exception'. |
| is_notification | BOOLEAN | true | Flag for system notifications | Distinguishes notifications from standard emails. |
| auto_delete | BOOLEAN | true | Flag for post-send deletion | If true, the record is deleted after sending. |
| scheduled_date | TIMESTAMP | true | Planned delivery time | Timezone is typically UTC. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timezone is typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Timezone is typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id` (Evidence: standard Odoo naming convention for linking mail to messages).
    - `create_uid` → `res_users.id` (Evidence: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Evidence: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII:** The `email_to`, `email_cc`, and `body_html` columns contain PII and should be masked or restricted in non-production environments.
- **Timezones:** All timestamp columns (`create_date`, `write_date`, `scheduled_date`) are stored in UTC.
- **Data Retention:** The `auto_delete` flag suggests that some records may be purged from the source system shortly after processing; query results may be incomplete if the ingestion process runs after the deletion.
- **State Logic:** The `state` column is the primary filter for analysis; ensure you handle 'exception' states when calculating delivery success rates.