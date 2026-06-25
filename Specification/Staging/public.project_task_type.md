# project_task_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`project_task_type`), the use of `JSONB` for localized fields, and the presence of standard Odoo audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the Project Management module, specifically defining the stages or types of tasks within a project workflow (e.g., "To Do", "In Progress", "Done"). It manages the configuration of these stages, including their display order, associated email/SMS templates for automation, and UI behaviors like folding columns in a Kanban view.

## Description
One row represents a single task stage or type definition within a project workflow. This is a raw landing copy of the configuration table, serving as the source for project stage dimensions in downstream reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| sequence | INTEGER | true | Display order index | Used to sort stages in the UI. |
| mail_template_id | INTEGER | true | Foreign key to email templates | Linked to the email template system. |
| rating_template_id | INTEGER | true | Foreign key to rating templates | Used for automated feedback requests. |
| user_id | INTEGER | true | Owner/Responsible user ID | Likely references a user in the system. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field for record updates. |
| name | JSONB | false | Stage name | Multilingual field stored as JSON. |
| active | BOOLEAN | true | Soft-delete flag | If false, the stage is hidden from UI. |
| fold | BOOLEAN | true | Kanban fold status | Determines if the stage is collapsed in Kanban. |
| auto_validation_state | BOOLEAN | true | Auto-validation trigger | Flag for automated state transitions. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| sms_template_id | INTEGER | true | Foreign key to SMS templates | Linked to the SMS notification system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id` (Guess: links to email configuration)
    - `rating_template_id` → `rating_template.id` (Guess: links to customer feedback configuration)
    - `sms_template_id` → `sms_template.id` (Guess: links to SMS configuration)
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo pattern for user references)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` field is `JSONB` and may contain localized strings; while generally not PII, ensure parsing logic handles the JSON structure correctly.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing audit analysis.
- **JSONB Parsing:** The `name` column requires extraction (e.g., `name->>'en_US'`) depending on the required language context.