# project_tags

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a `JSONB` column for `name` (often used for multi-language support in Odoo), is highly characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the project management module by maintaining a registry of tags used to categorize or label project tasks and issues. These tags allow users to filter and organize work items within the project-to-cash or task-tracking business processes.

## Description
One row in this table represents a single project tag definition available for assignment to project tasks. This is a raw staging table containing the direct landing of tag metadata, including localization-ready names and audit tracking for creation and modification events.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| color | INTEGER | true | UI color index | Represents the color code assigned to the tag in the application UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the tag. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the tag. |
| name | JSONB | false | Tag display name | Likely contains localized strings (e.g., {"en_US": "Urgent", "fr_FR": "Urgent"}). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for user references).
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, it is stored as `JSONB` and may not be unique across all language keys.

## Caveats for downstream consumers

- **PII/Sensitivity:** No direct PII, though `create_uid` and `write_uid` link to user identities.
- **Timestamps:** Assumed to be in UTC.
- **Data Format:** The `name` column is `JSONB`; ensure your downstream transformation logic handles JSON extraction (e.g., `name->>'en_US'`) to retrieve human-readable text.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag; assume all rows are currently active unless otherwise specified by business logic.