# project_project_stage

## Source system
This table originates from Odoo ERP. The naming convention `project_project_stage`, the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, and the use of `JSONB` for localized fields (like `name`) are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the Project Management module, specifically defining the workflow stages (e.g., "To Do", "In Progress", "Done") for project tasks. It manages the configuration of these stages, including their display order, associated automated communications (`mail_template_id`, `sms_template_id`), and UI behavior such as whether a stage is folded in the Kanban view.

## Description
One row represents a single project stage definition within the Odoo project management system. It acts as a raw landed copy of the configuration entity, capturing the stage's metadata, its sequence in the workflow, and its association with automated notification templates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| sequence | INTEGER | true | Display order | Determines the position of the stage in Kanban views. |
| mail_template_id | INTEGER | true | Email template ID | Foreign key to the email template used for stage transitions. |
| company_id | INTEGER | true | Company ID | Multi-company context identifier. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this stage. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified this stage. |
| name | JSONB | false | Stage name | Multilingual name stored as a JSON object. |
| active | BOOLEAN | true | Active status | Soft-delete flag; false indicates the stage is archived. |
| fold | BOOLEAN | true | Folded status | Indicates if the stage is collapsed in the Kanban view. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| sms_template_id | INTEGER | true | SMS template ID | Foreign key to the SMS template used for stage transitions. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_template_id` → `mail_template.id` (Guess: links to Odoo's email template configuration).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo user audit links).
    - `sms_template_id` → `sms_template.id` (Guess: links to Odoo's SMS template configuration).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` field is `JSONB` and may contain localized strings; while unlikely to contain PII, it should be inspected if used in reporting.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are stored in UTC by the Odoo framework.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless auditing archived stages.
- **JSONB Handling:** The `name` column requires PostgreSQL JSONB operators (e.g., `name->>'en_US'`) to extract specific language values.