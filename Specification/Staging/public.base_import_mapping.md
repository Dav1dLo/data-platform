# base_import_mapping

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `res_model`, `create_uid`, `write_uid`, `base_import_mapping`) is characteristic of Odoo's internal ORM metadata structures used to manage data import configurations.

## Functional process 
This table supports the data import process, specifically mapping external file columns to internal system fields. It tracks how specific columns from an imported dataset (e.g., a CSV or Excel file) are mapped to the corresponding fields (`field_name`) within a specific Odoo model (`res_model`).

## Description
One row represents a single mapping configuration between an external column name and an internal database field for a specific model. This is a staging table containing raw configuration records used to facilitate bulk data ingestion into the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_import_mapping_id_seq`. |
| create_uid | INTEGER | true | User ID who created the mapping | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the mapping | References `res_users.id`. |
| res_model | VARCHAR | true | Target Odoo model name | e.g., 'res.partner', 'product.product'. |
| column_name | VARCHAR | true | Name of the column in the source file | The header name from the imported file. |
| field_name | VARCHAR | true | Internal field name in the target model | The technical field name in Odoo. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit field pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `res_model` column contains string identifiers for Odoo models; these are not foreign keys to a single table but represent dynamic references to the system's object registry.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table is a configuration/metadata store; it does not contain business transaction data but rather the "instructions" for how data was imported.
- No explicit soft-delete flag is present; records are likely managed via direct deletion or lifecycle management within the Odoo import module.