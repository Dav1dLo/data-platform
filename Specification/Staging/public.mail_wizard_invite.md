# mail_wizard_invite

## Source system
This table originates from an Odoo ERP environment. The naming convention `mail_wizard_invite` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and polymorphic reference fields (`res_id`, `res_model`) are characteristic of the Odoo framework's messaging and notification system.

## Functional process 
This table supports the "Communication and Collaboration" business process, specifically tracking invitations sent via email wizards within the application. It captures the context of an invitation, including the target record being referenced (`res_model` and `res_id`), the content of the invitation message, and whether notifications are enabled.

## Description
One row in this table represents a single instance of an email invitation wizard session initiated by a user. It serves as a raw landed copy of the transient state or history of these invitations, stored at the grain of one invitation event per record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mail_wizard_invite_id_seq`. |
| res_id | INTEGER | true | ID of the related record | The specific object ID being referenced. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| res_model | VARCHAR | false | Related model name | The technical name of the Odoo model (e.g., 'res.partner'). |
| message | TEXT | true | Invitation message body | The text content sent or displayed in the invite. |
| notify | BOOLEAN | true | Notification flag | Indicates if the recipient should be notified. |
| create_date | TIMESTAMP | true | Record creation timestamp | Typically in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Typically in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for user who created the record).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for user who last updated the record).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII:** The `message` column may contain sensitive user communication or email addresses.
- **Timezone:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Polymorphism:** The `res_id` and `res_model` columns form a polymorphic relationship; queries joining against these must filter by `res_model` to ensure referential integrity.
- **Data Retention:** This table represents a staging layer; it may contain transient data or duplicates depending on the ingestion frequency and source system cleanup policies.