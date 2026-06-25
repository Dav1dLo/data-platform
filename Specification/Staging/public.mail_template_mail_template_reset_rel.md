# mail_template_mail_template_reset_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (link tables) between two entities.

## Functional process 
This table supports the email notification and template management process. It facilitates the association between specific email templates and their corresponding reset configurations, likely used for password recovery or account verification workflows.

## Description
One row in this table represents a single association between a `mail_template` and a `mail_template_reset` configuration. This is a junction table used to resolve a many-to-many relationship in the staging layer, maintaining the raw link between these two entities as defined in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_template_reset_id | INTEGER | false | Foreign key to the reset configuration entity. | Part of the composite primary key. |
| mail_template_id | INTEGER | false | Foreign key to the email template entity. | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(mail_template_reset_id, mail_template_id)`
- **Foreign keys (inferred):** 
    - `mail_template_reset_id → mail_template_reset.id`: Guessed based on the column name suffix matching a standard entity ID.
    - `mail_template_id → mail_template.id`: Guessed based on the column name suffix matching a standard entity ID.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a link table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present to indicate when these associations were created or modified.
- Ensure joins to parent tables handle potential orphans if the source system does not enforce strict referential integrity at the database level.