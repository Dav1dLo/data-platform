# mail_notification_mail_resend_message_rel

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework that utilizes an ORM to manage many-to-many relationships. The naming convention `_rel` is a standard pattern for join tables in such systems, specifically linking notification entities to message resend logs.

## Functional process 
This table supports the communication and notification management process. It maintains the association between specific mail notifications and the corresponding resend message attempts, ensuring that the system can track which messages were triggered by which notification events.

## Description
One row in this table represents a single link between a mail notification and a mail resend message. It serves as a junction table in the staging layer, providing a raw, normalized representation of the many-to-many relationship between these two entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_resend_message_id | INTEGER | false | Foreign key to the mail resend message entity. | Part of the composite primary key. |
| mail_notification_id | INTEGER | false | Foreign key to the mail notification entity. | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(mail_resend_message_id, mail_notification_id)`
- **Foreign keys (inferred):** 
    - `mail_resend_message_id` → `mail_resend_message.id`: Links to the specific message resend record.
    - `mail_notification_id` → `mail_notification.id`: Links to the parent notification record.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- Ensure that joins against this table are handled as a composite key to avoid Cartesian products.
- As a staging table, it reflects the raw state of the source system; verify if the source system performs hard or soft deletes on these relationships.