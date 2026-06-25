# account_report_column

## Source system
The table likely originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields (like `name`), which are characteristic of Odoo's PostgreSQL-based architecture.

## Functional process 
This table supports the configuration of financial or analytical report layouts. It defines the specific columns that appear in custom reports, managing their display order, data types, and formatting logic (such as whether to suppress zero values).

## Description
One row represents a single column definition within a specific report configuration. It acts as a raw landed copy of the report structure metadata, capturing how data should be presented and calculated for end-users.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_report_column_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the left-to-right position in the report. |
| report_id | INTEGER | true | Foreign key to the parent report | Links this column to a specific report definition. |
| custom_audit_action_id | INTEGER | true | Audit log reference | Links to a custom audit action record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| expression_label | VARCHAR | false | Unique identifier for the expression | Used to reference the column in report formulas. |
| figure_type | VARCHAR | false | Data type of the column value | Defines if the column displays currency, percentage, etc. |
| name | JSONB | false | Column display name | Multilingual label stored as a JSON object. |
| sortable | BOOLEAN | true | Sortability flag | Indicates if the column can be sorted in the UI. |
| blank_if_zero | BOOLEAN | true | Zero-suppression flag | If true, hides the value if it equals zero. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job/system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job/system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `report_id` → `account_report.id` (Likely parent table for report definitions).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **JSONB:** The `name` column is a `JSONB` object; query writers should use the `->>` operator to extract specific language keys (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are current unless otherwise specified by the source system logic.