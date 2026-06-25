# theme_ir_asset

## Source system
The table likely originates from an Odoo ERP system. The naming convention (`ir_asset`), the presence of `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, and the use of a sequence-based default for the `id` column are characteristic patterns of the Odoo "Ir" (Internal Resource) framework.

## Functional process 
This table supports the management of web assets (CSS, JS, or image files) within the Odoo web framework. It tracks the registration and ordering of assets that are bundled and served to the frontend, using the `bundle` and `path` columns to define which resources are loaded for specific views or themes.

## Description
One row represents a single asset file or resource entry registered within the system's theme framework. This is a raw landed copy of the internal resource asset table, capturing the configuration, file path, and active status of assets used for rendering the user interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `theme_ir_asset_id_seq`. |
| sequence | INTEGER | false | Display or load order | Determines the priority of asset loading. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| key | VARCHAR | true | Unique identifier key | Often used for programmatic lookups. |
| name | VARCHAR | false | Asset display name | Human-readable label for the asset. |
| bundle | VARCHAR | false | Asset bundle name | The group/bundle this asset belongs to. |
| directive | VARCHAR | true | Asset directive | Specific instruction for asset processing. |
| path | VARCHAR | false | File system path | The location of the asset file. |
| target | VARCHAR | true | Target destination | Defines where the asset is injected. |
| active | BOOLEAN | true | Soft-delete flag | If false, the asset is ignored by the system. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `path` (Assuming file paths are unique within the asset registry).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may link to employee or user records.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing historical analysis.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the ingestion process is interrupted; verify row counts against the source system if performing reconciliation.