# mail_alias

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `alias_model_id`, `create_uid`, `write_uid`, and the use of `nextval` sequences) is characteristic of the Odoo framework's internal mail routing and alias management system.

## Functional process 
This table supports the email routing and communication automation process. It defines how incoming emails are mapped to specific business objects (like CRM leads, support tickets, or project tasks) within the platform, managing the logic for thread association and default record values.

## Description
One row in this table represents a single email alias configuration used to route incoming messages to specific system entities. This is a raw staging table containing the direct configuration state of mail aliases, serving as the foundation for downstream communication analytics and routing logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_alias_id_seq`. |
| alias_domain_id | INTEGER | true | Foreign key to the domain | Links to the email domain configuration. |
| alias_model_id | INTEGER | false | Target model ID | The Odoo model (e.g., crm.lead) receiving the mail. |
| alias_force_thread_id | INTEGER | true | Forced thread ID | Overrides automatic thread detection. |
| alias_parent_model_id | INTEGER | true | Parent model ID | Used for hierarchical record association. |
| alias_parent_thread_id | INTEGER | true | Parent thread ID | Used for hierarchical thread association. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the alias. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the alias. |
| alias_name | VARCHAR | true | Alias local part | The prefix of the email address (e.g., 'sales'). |
| alias_full_name | VARCHAR | true | Full display name | The descriptive name for the alias. |
| alias_contact | VARCHAR | false | Contact policy | Defines who can send to this alias. |
| alias_status | VARCHAR | true | Alias status | Current operational status of the alias. |
| alias_bounced_content | JSONB | true | Bounce metadata | Stores details regarding bounced email attempts. |
| alias_defaults | TEXT | false | Default values | JSON-encoded string of default field values. |
| alias_incoming_local | BOOLEAN | true | Local routing flag | Indicates if the alias is for local routing. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the system at insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the system at last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `alias_domain_id` → `mail_alias_domain.id` (Guess: standard Odoo domain link)
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail)
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail)
- **Natural keys (inferred):** 
    - `alias_name` (in combination with `alias_domain_id`)

## Caveats for downstream consumers

- **Sensitive Data:** The `alias_bounced_content` column may contain PII from bounced email headers or body content; handle with care.
- **Timestamps:** Timestamps are stored in the system's local time (typically UTC in Odoo, but verify against server configuration).
- **Data Format:** `alias_defaults` is stored as a `TEXT` field but contains serialized data (likely JSON or Python dict string); it will require parsing in downstream transformations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are active unless otherwise specified by business logic.