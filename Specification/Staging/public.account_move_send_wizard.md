# account_move_send_wizard

## Source system
This table originates from an Odoo ERP environment. The naming convention `account_move_send_wizard` and the presence of columns like `move_id`, `mail_template_id`, and `create_uid` are characteristic of Odoo's transient models (wizards) used to manage the workflow of sending accounting documents (invoices/moves) to customers.

## Functional process 
This table supports the "Invoice-to-Cash" or "Accounts Receivable" communication process. It tracks the state and configuration of the wizard used to dispatch accounting moves (invoices) via email or other electronic formats, capturing user-defined subjects, bodies, and attachment configurations before the final transmission.

## Description
One row in this table represents a single instance of an "Account Move Send" wizard session, capturing the configuration parameters for sending a specific accounting document. As a staging table, it serves as a raw, landed copy of the transient wizard state, which is typically used to facilitate the UI-driven dispatch of invoices.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| move_id | INTEGER | false | Foreign key to the accounting move | The specific invoice or journal entry being processed. |
| pdf_report_id | INTEGER | true | Reference to the PDF report template | The ID of the report format used for the document. |
| mail_template_id | INTEGER | true | Reference to the email template | The ID of the template used for the email body. |
| create_uid | INTEGER | true | Creator user ID | The user who initiated the wizard session. |
| write_uid | INTEGER | true | Last modifier user ID | The user who last updated the wizard configuration. |
| mail_subject | VARCHAR | true | Email subject line | The text used as the subject for the outgoing email. |
| sending_method_checkboxes | JSONB | true | Transmission method settings | JSON blob containing flags for selected delivery methods. |
| extra_edi_checkboxes | JSONB | true | EDI configuration flags | JSON blob containing settings for electronic data interchange. |
| mail_attachments_widget | JSONB | true | Attachment metadata | JSON blob detailing files attached to the email. |
| mail_body | TEXT | true | Email body content | The HTML or plain text content of the email. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard session was started. |
| write_date | TIMESTAMP | true | Last modification timestamp | Timestamp when the wizard session was last updated. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `move_id` → `account_move.id` (Inferred from Odoo naming conventions linking wizards to the target record).
    - `mail_template_id` → `mail_template.id` (Standard Odoo reference to email templates).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `mail_body` and `mail_subject` columns may contain PII or sensitive customer communication; ensure appropriate masking if exposing to non-authorized users.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **JSONB Content:** The `sending_method_checkboxes`, `extra_edi_checkboxes`, and `mail_attachments_widget` columns contain semi-structured data; query writers should use PostgreSQL JSONB operators (e.g., `->>`) to extract specific values.
- **Transient Nature:** As a "wizard" table, rows may be ephemeral or frequently purged depending on the Odoo system's cleanup policies.