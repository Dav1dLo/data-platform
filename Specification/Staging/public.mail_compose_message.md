# mail_compose_message

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention, specifically the use of `res_` prefixes (e.g., `res_domain_user_id`), `create_uid`/`write_uid` audit columns, and the `mail_compose_message` entity name, are characteristic of the Odoo framework's messaging and communication module.

## Functional process 
This table supports the communication and notification engine within the ERP. It acts as a staging area for outgoing emails and internal messages, capturing the state of a message composition before it is sent or logged against a specific business record (e.g., an invoice, a lead, or a project task).

## Description
One row in this table represents a single message composition event, capturing the content, metadata, and configuration of an email or internal notification. It serves as a raw landing copy of the Odoo `mail.compose.message` model, tracking the lifecycle of message drafting and dispatching within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| template_id | INTEGER | true | Foreign key to email template | Links to the template used for the message. |
| parent_id | INTEGER | true | Parent message ID | Used for threading/replies. |
| author_id | INTEGER | true | Author user/partner ID | The sender of the message. |
| res_domain_user_id | INTEGER | true | Resource domain user ID | Contextual user ID for the domain. |
| record_alias_domain_id | INTEGER | true | Alias domain ID | Domain configuration for the message. |
| record_company_id | INTEGER | true | Company ID | Multi-company context for the message. |
| subtype_id | INTEGER | true | Message subtype ID | Categorizes the message (e.g., comment, note). |
| mail_activity_type_id | INTEGER | true | Activity type ID | Links to specific CRM/Project activities. |
| mail_server_id | INTEGER | true | Mail server ID | The outgoing SMTP server configuration. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Audit: user who last updated the record. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US'). |
| subject | VARCHAR | true | Email subject line | The subject of the message. |
| email_layout_xmlid | VARCHAR | true | Layout XML ID | Reference to the email template layout. |
| email_from | VARCHAR | true | Sender email address | The 'From' field in the email header. |
| composition_mode | VARCHAR | true | Composition mode | e.g., 'comment', 'mass_mail'. |
| model | VARCHAR | true | Target model name | The Odoo model the message relates to. |
| record_name | VARCHAR | true | Record display name | Human-readable name of the target record. |
| message_type | VARCHAR | false | Message type | e.g., 'email', 'comment', 'notification'. |
| reply_to | VARCHAR | true | Reply-to address | The address for incoming replies. |
| scheduled_date | VARCHAR | true | Scheduled send date | String-based timestamp for delayed sending. |
| template_name | VARCHAR | true | Template name | Denormalized name of the used template. |
| body | TEXT | true | Message content | The HTML or plain text body of the message. |
| res_ids | TEXT | true | Target record IDs | List of IDs the message is associated with. |
| res_domain | TEXT | true | Domain filter | Filter criteria for mass mailing targets. |
| email_add_signature | BOOLEAN | true | Add signature flag | Whether to append the user's signature. |
| reply_to_force_new | BOOLEAN | true | Force new reply-to | Flag to override default reply-to behavior. |
| auto_delete | BOOLEAN | true | Auto-delete flag | Whether to delete after sending. |
| auto_delete_keep_log | BOOLEAN | true | Keep log flag | Whether to retain logs after auto-delete. |
| force_send | BOOLEAN | true | Force send flag | Whether to send immediately. |
| use_exclusion_list | BOOLEAN | true | Use exclusion list | Flag for mass mailing opt-outs. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Modification timestamp | UTC timestamp of last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `template_id` → `mail_template.id` (Guess: links to email template definitions)
    - `author_id` → `res_partner.id` (Guess: standard Odoo pattern for message authors)
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` and `email_from` columns may contain PII or sensitive business communication content.
- **Timestamps:** `create_date` and `write_date` are stored in UTC. `scheduled_date` is stored as a `VARCHAR` and may require casting or parsing for time-series analysis.
- **Soft Deletes:** Odoo typically does not use soft-delete flags in this table; records are generally permanent unless purged by system maintenance.
- **Data Grain:** This table contains both individual messages and mass-mailing drafts; `composition_mode` should be used to filter the intended scope of analysis.