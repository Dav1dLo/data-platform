# sms_template

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields like `name`, which is characteristic of Odoo's multi-language support.

## Functional process 
This table supports the automated communication and notification engine. It stores templates used for sending SMS messages triggered by specific business events or models within the platform, allowing for dynamic content generation based on the associated `model_id`.

## Description
One row represents a single SMS template definition, including its localized name and the message body content. This is a raw staging table containing the direct landing of template configurations from the source system, intended for use in downstream communication workflows.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `sms_template_id_seq`. |
| model_id | INTEGER | false | Related business model ID | References the object type the template is associated with. |
| sidebar_action_id | INTEGER | true | UI action reference | Links to a specific sidebar action in the source application. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the template. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the template. |
| template_fs | VARCHAR | true | Filesystem path | Path to a file-based template if not stored in the database. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US'). |
| model | VARCHAR | true | Model technical name | The technical name of the associated business model. |
| name | JSONB | true | Template name | Localized name stored as a JSON object. |
| body | JSONB | false | Message content | The actual SMS text content, potentially containing placeholders. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` and `body` columns are `JSONB` types; ensure your query logic handles JSON extraction (e.g., `body->>'en_US'`) to access the actual text.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no explicit soft-delete flag, but Odoo-based tables often rely on the presence of the record itself; verify if records are purged or archived in the source.
- `model_id` and `model` columns are likely redundant or linked; ensure you understand the join logic to the relevant metadata tables in the source system.