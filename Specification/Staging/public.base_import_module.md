# base_import_module

## Source system
This table originates from an Odoo ERP system. The naming convention `base_import_module`, the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default for the `id` column are characteristic patterns of the Odoo framework's internal module management and data import infrastructure.

## Functional process 
This table supports the module installation and data import pipeline within the ERP. It tracks the state of imported modules, their dependencies, and the binary files associated with the import process, facilitating the deployment of custom or third-party functionality into the application environment.

## Description
One row in this table represents a single module import request or installation task. It serves as a staging record that captures the configuration, status, and binary payload of a module being introduced to the system. This is a raw landing record used to track the lifecycle of module imports.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `base_import_module_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| state | VARCHAR | true | Current status of the import | Likely values include 'init', 'done', 'error'. |
| import_message | TEXT | true | Log or error message from import | Contains diagnostic info if import fails. |
| modules_dependencies | TEXT | true | List of required modules | Often stored as a JSON or comma-separated string. |
| force | BOOLEAN | true | Force installation flag | If true, overrides standard dependency checks. |
| with_demo | BOOLEAN | true | Include demo data flag | Determines if sample data is loaded with module. |
| create_date | TIMESTAMP | true | Record creation timestamp | System-generated audit field. |
| write_date | TIMESTAMP | true | Last update timestamp | System-generated audit field. |
| module_file | BYTEA | false | Binary content of the module | The actual file payload (e.g., .zip or .tar.gz). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `module_file` column contains binary data (BYTEA); queries selecting this column may be slow or cause memory issues if not handled carefully.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not appear to implement soft deletes; records are likely permanent unless purged by a maintenance job.
- The `modules_dependencies` column is stored as text and may require parsing (e.g., `jsonb_array_elements` if stored as JSON) to be useful for dependency analysis.