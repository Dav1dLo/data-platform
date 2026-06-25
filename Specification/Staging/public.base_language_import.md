# base_language_import

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based primary key (`base_language_import_id_seq`) are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the localization and translation management process. It stores uploaded language files (likely `.po` or `.csv` files) used to import translations into the system, allowing administrators to update or overwrite existing language strings across the platform.

## Description
One row in this table represents a single language file import event, containing the metadata and the raw binary content of the translation file. As a staging table, it serves as a raw landing point for translation data before it is processed and applied to the system's language configuration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `base_language_import_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users.id`. |
| name | VARCHAR | false | Descriptive name of the language import | Often reflects the language or purpose. |
| code | VARCHAR | false | Language code (e.g., 'en_US') | ISO-style language identifier. |
| filename | VARCHAR | false | Original name of the uploaded file | Includes file extension. |
| overwrite | BOOLEAN | true | Flag to overwrite existing translations | If true, existing strings are replaced. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| data | BYTEA | false | Binary content of the translation file | Raw file data stored as a byte array. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming for creator tracking).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming for updater tracking).
- **Natural keys (inferred):** 
    - None confidently inferable; the table relies on the surrogate `id`.

## Caveats for downstream consumers

- The `data` column contains binary large object (BYTEA) data; ensure your query tool can handle or exclude this column to avoid performance issues.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not implement soft deletes; records are typically permanent unless explicitly removed by the application logic.
- The `overwrite` flag is critical for understanding the impact of the import on the target system's translation state.