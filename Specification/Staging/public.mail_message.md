# mail_message

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `res_id`, `create_uid`, `write_uid`, `model`) and the specific structure of the mail messaging system are characteristic of Odoo's internal communication and chatter framework.

## Functional process 
This table supports the internal and external communication tracking process, often referred to as the "Chatter" or "Mail Thread" system. It logs emails, internal notes, and system notifications associated with specific business records (e.g., sales orders, invoices, or CRM leads), facilitating audit trails and collaborative workflows.

## Description
One row represents a single communication event, such as an email sent/received, an internal note, or a system-generated notification. This table acts as a raw landing copy of the Odoo `mail.message` model, capturing the content, metadata, and relational context of messages within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| parent_id | INTEGER | true | Parent message ID | Used for threading replies. |
| res_id | INTEGER | true | Related record ID | The ID of the business object the message is linked to. |
| record_alias_domain_id | INTEGER | true | Alias domain ID | Reference to the email domain configuration. |
| record_company_id | INTEGER | true | Company ID | The company context for the message. |
| subtype_id | INTEGER | true | Message subtype ID | Categorizes the message (e.g., comment, notification). |
| mail_activity_type_id | INTEGER | true | Activity type ID | Links the message to a specific activity type. |
| author_id | INTEGER | true | Author partner ID | The partner (user/contact) who sent the message. |
| author_guest_id | INTEGER | true | Author guest ID | Used for unauthenticated guest users. |
| mail_server_id | INTEGER | true | Mail server ID | The outgoing mail server used to send the message. |
| create_uid | INTEGER | true | Creator user ID | The user who created the record. |
| write_uid | INTEGER | true | Updater user ID | The user who last updated the record. |
| subject | VARCHAR | true | Message subject | The email subject line. |
| model | VARCHAR | true | Related model name | The technical name of the Odoo model (e.g., 'sale.order'). |
| record_name | VARCHAR | true | Related record name | Display name of the related business object. |
| message_type | VARCHAR | false | Message type | e.g., 'email', 'comment', 'notification'. |
| email_from | VARCHAR | true | Sender email address | The raw email address of the sender. |
| message_id | VARCHAR | true | Message-ID header | The unique RFC 5322 message identifier. |
| reply_to | VARCHAR | true | Reply-to address | The email address for replies. |
| email_layout_xmlid | VARCHAR | true | Layout XML ID | Reference to the email template layout. |
| body | TEXT | true | Message content | The HTML or plain text body of the message. |
| is_internal | BOOLEAN | true | Internal flag | True if the message is for internal users only. |
| reply_to_force_new | BOOLEAN | true | Force new thread | Flag to force a new thread in the mail client. |
| email_add_signature | BOOLEAN | true | Add signature flag | Whether to append the user's signature. |
| date | TIMESTAMP | true | Message date | The timestamp of the message creation. |
| pinned_at | TIMESTAMP | true | Pinned timestamp | When the message was pinned in the UI. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp for record creation. |
| write_date | TIMESTAMP | true | Update timestamp | Audit timestamp for last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `author_id` → `res_partner.id` (Guess: links to the partner who authored the message).
    - `create_uid` → `res_users.id` (Guess: links to the user who created the record).
    - `mail_server_id` → `ir_mail_server.id` (Guess: links to the configured outgoing mail server).
- **Natural keys (inferred):**
    - `message_id` (The RFC 5322 Message-ID is globally unique for emails).

## Caveats for downstream consumers

- **Sensitive Data:** The `body` and `email_from` columns may contain PII or sensitive business communication; ensure appropriate masking for non-privileged users.
- **Timezones:** Timestamps (`date`, `create_date`, `write_date`) are typically stored in UTC in Odoo, but verify against the specific Odoo instance configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are removed physically if deleted in the source.
- **Content:** The `body` column contains raw HTML content; downstream consumers may need to strip tags for analysis.