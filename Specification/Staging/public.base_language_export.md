# base_language_export

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `BYTEA` for data storage are characteristic patterns of the Odoo framework's ORM layer for managing exported language files.

## Functional process 
This table supports the localization and translation management process within the ERP. It tracks the generation of language export files (such as PO or CSV files) used to translate system interfaces or documents, capturing the configuration of the export, the target language, and the resulting binary data blob.

## Description
One row represents a single language export request or generated file record. The grain is one row per export event, capturing metadata about the export configuration and the binary content of the exported language file. This is a raw landed copy of the Odoo `base.language.export` model, serving as a staging entity for translation workflows.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_language_export_id_seq`. |
| model_id | INTEGER | true | Reference to the Odoo model | Likely links to `ir_model` table. |
| create_uid | INTEGER | true | Creator user ID | Links to the user who initiated the export. |
| write_uid | INTEGER | true | Last modifier user ID | Links to the user who last updated the record. |
| name | VARCHAR | true | Export name | Descriptive label for the export file. |
| lang | VARCHAR | false | Language code | ISO language code (e.g., 'en_US'). |
| format | VARCHAR | false | File format | Format of the export (e.g., 'po', 'csv'). |
| export_type | VARCHAR | false | Export type | Defines the scope of the export. |
| domain | VARCHAR | true | Filter domain | The Odoo domain filter used to select records. |
| state | VARCHAR | true | Record status | Current lifecycle state of the export. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |
| data | BYTEA | true | Binary file content | The actual exported file data in binary format. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `model_id` → `ir_model.id` (Guess: standard Odoo reference to system models).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `data` column contains binary file content which may include proprietary translation strings or sensitive system labels.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted by the source system.
- **Binary Data:** The `data` column is a `BYTEA` type; ensure your downstream tools are configured to handle binary streams or hex-encoded strings when querying this column.