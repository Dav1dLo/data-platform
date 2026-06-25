# mail_template

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `JSONB` fields for translatable content, and `ref_ir_act_window`) is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the automated communication and notification engine within the ERP. It stores templates used for generating outgoing emails, including configuration for recipients, subjects, and HTML bodies, which are triggered by specific business events or user actions defined by the `model` column.

## Description
One row in this table represents a single email template configuration used for system-generated correspondence. It acts as a raw landed copy of the Odoo `mail.template` model, storing both the structural metadata (server IDs, model associations) and the localized content (subjects and bodies) required to render emails dynamically.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| model_id | INTEGER | true | Associated database model ID | Links to the Odoo model definition. |
| user_id | INTEGER | true | Owner user ID | The user responsible for this template. |
| mail_server_id | INTEGER | true | Outgoing mail server ID | References the SMTP configuration to use. |
| ref_ir_act_window | INTEGER | true | Window action reference | UI context for the template. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for updates. |
| template_fs | VARCHAR | true | Filesystem path | Path if the template is stored on disk. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US'). |
| model | VARCHAR | true | Model technical name | The object type this template applies to. |
| email_from | VARCHAR | true | Sender email address | Can contain placeholders. |
| email_to | VARCHAR | true | Recipient email address | Can contain placeholders. |
| partner_to | VARCHAR | true | Partner ID string | Comma-separated partner IDs. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list. |
| reply_to | VARCHAR | true | Reply-to email address | Override for reply headers. |
| email_layout_xmlid | VARCHAR | true | Layout XML ID | Reference to the email wrapper template. |
| scheduled_date | VARCHAR | true | Scheduled date expression | Jinja2 expression for scheduling. |
| name | JSONB | true | Template name | Translatable name field. |
| description | JSONB | true | Template description | Translatable description. |
| subject | JSONB | true | Email subject line | Translatable subject. |
| body_html | JSONB | true | Email body content | Translatable HTML content. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| use_default_to | BOOLEAN | true | Use default recipient | Flag to use model-level defaults. |
| auto_delete | BOOLEAN | true | Auto-delete flag | If true, deletes email after sending. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
    - `mail_server_id` → `ir_mail_server.id` (References the outgoing SMTP server configuration).
- **Natural keys (inferred):** Not confidently inferable; Odoo templates are typically identified by their internal ID or unique name/model combinations.

## Caveats for downstream consumers

- **JSONB content:** The `name`, `description`, `subject`, and `body_html` columns contain JSONB data, which likely stores translations (e.g., `{"en_US": "Hello", "fr_FR": "Bonjour"}`). You will need to use the `->>` operator to extract specific language values.
- **Timestamps:** All timestamps are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure your queries filter by `active = true` unless you intend to include archived templates.
- **PII:** `email_from`, `email_to`, and `email_cc` may contain PII; ensure appropriate masking if exposing this data to non-authorized users.