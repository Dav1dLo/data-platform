# base_import_import

## Source system
This table originates from an Odoo ERP system. The naming convention `base_import_import` and the presence of columns like `res_model`, `create_uid`, and `write_uid` are characteristic of Odoo's internal data import management framework.

## Functional process 
This table supports the data import process within the ERP, tracking the history and metadata of files uploaded by users to perform bulk data imports. It acts as a staging log for tracking which models (e.g., products, partners) were targeted by specific file uploads.

## Description
One row in this table represents a single file import event initiated by a user. It stores the metadata of the import, including the target model, the original filename, and the binary content of the uploaded file. As a staging table, it serves as a raw record of import attempts before or during the processing of the data into the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the user who initiated the import. |
| write_uid | INTEGER | true | User ID who last modified the record | References the user who last updated the import status. |
| res_model | VARCHAR | true | Target Odoo model | The technical name of the model being imported into (e.g., 'res.partner'). |
| file_name | VARCHAR | true | Original name of the uploaded file | Includes file extension. |
| file_type | VARCHAR | true | MIME type or format of the file | e.g., 'csv', 'xlsx'. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC. |
| file | BYTEA | true | Binary content of the uploaded file | Contains the raw data payload. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `file` column contains binary data (`BYTEA`); queries selecting this column may return large payloads and should be handled with care.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not appear to implement soft deletes; rows represent distinct import events.
- Sensitive information may be present in the `file` content depending on what users have uploaded; ensure appropriate access controls are applied.