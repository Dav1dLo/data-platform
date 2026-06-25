# mail_activity_type_mail_template_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables between two entities, in this case, mail activity types and mail templates.

## Functional process 
This table supports the communication and notification module, specifically managing the association between activity types (e.g., "Email", "Call", "Meeting") and the specific email templates that should be triggered or associated with those activities. It enables the system to dynamically select the correct email content based on the type of activity being performed.

## Description
This table represents a join entity that links mail activity types to mail templates. Each row defines a valid association between one activity type and one template, facilitating a many-to-many relationship. It serves as a raw landing copy of the relational mapping table from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_activity_type_id | INTEGER | false | Foreign key to the mail activity type definition. | Part of the composite primary key. |
| mail_template_id | INTEGER | false | Foreign key to the mail template definition. | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(mail_activity_type_id, mail_template_id)`
- **Foreign keys (inferred):** 
    - `mail_activity_type_id → mail_activity_type.id`: Links to the definition of the activity type.
    - `mail_template_id → mail_template.id`: Links to the specific email template content.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when these relationships were created or modified from this table alone.
- As a staging table, it should be joined with the corresponding master tables (`mail_activity_type` and `mail_template`) to provide meaningful context for reporting.