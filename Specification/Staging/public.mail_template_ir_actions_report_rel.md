# mail_template_ir_actions_report_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific prefix `mail_template_` and `ir_actions_report_` is characteristic of Odoo's internal many-to-many relationship tables used to link email templates to report actions.

## Functional process 
This table supports the document reporting and communication workflow. It manages the association between email templates and report actions, allowing the system to determine which email template should be used when a specific report (e.g., an invoice or purchase order) is generated or sent via email.

## Description
One row in this table represents a single link between a specific email template and a report action. It acts as a join table in the staging layer, providing a raw, un-transformed mapping of the many-to-many relationship between the `mail_template` and `ir_actions_report` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_template_id | INTEGER | false | Foreign key to the mail template definition | Links to the primary key of the mail template table. |
| ir_actions_report_id | INTEGER | false | Foreign key to the report action definition | Links to the primary key of the report actions table. |

## Keys

- **Primary key (inferred):** The composite of (`mail_template_id`, `ir_actions_report_id`).
- **Foreign keys (inferred):**
    - `mail_template_id` → `mail_template.id`: This column references the unique identifier of an email template.
    - `ir_actions_report_id` → `ir_actions_report.id`: This column references the unique identifier of a report action.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table.
- As a staging table, it reflects the raw state of the Odoo database; ensure that downstream models handle potential orphaned records if referential integrity is not strictly enforced in the source.