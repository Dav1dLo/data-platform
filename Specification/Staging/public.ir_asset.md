# ir_asset

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit columns for Odoo models, alongside the `ir_` prefix commonly used for Odoo's internal registry tables.

## Functional process 
This table supports the web asset management process, specifically tracking static assets (CSS, JS, images) used within the Odoo website builder. It manages the bundling and pathing of resources required for rendering website themes and templates.

## Description
One row in this table represents a single static asset file or resource entry registered within the system. It serves as a raw landed copy of the asset registry, capturing metadata such as the file path, associated bundle, and the specific website or theme template to which the asset belongs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_asset_id_seq`. |
| sequence | INTEGER | false | Display or processing order | Used to determine asset loading priority. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| name | VARCHAR | false | Asset name or label | Human-readable identifier for the asset. |
| bundle | VARCHAR | false | Asset bundle category | Groups assets (e.g., 'web.assets_common'). |
| directive | VARCHAR | true | Processing directive | Specific instruction for asset compilation. |
| path | VARCHAR | false | File system or URL path | The location of the asset file. |
| target | VARCHAR | true | Target destination | Often used for specific deployment targets. |
| active | BOOLEAN | true | Soft-delete flag | If false, the asset is excluded from builds. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| website_id | INTEGER | true | Associated website ID | References `website.website`. |
| theme_template_id | INTEGER | true | Associated theme template ID | References `theme.ir.ui.view`. |
| key | VARCHAR | true | Unique asset key | Often used for cache busting or lookups. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `website_id` → `website.id` (Links asset to a specific website instance)
    - `theme_template_id` → `ir_ui_view.id` (Links asset to a theme template)
- **Natural keys (inferred):** 
    - `key` (Likely used by the application to uniquely identify the asset resource)

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should typically filter by `WHERE active = TRUE` to retrieve only current, valid assets.
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo user IDs and do not contain PII, but they are meaningless without a join to the `res_users` table.
- **Data Integrity:** As a staging table, this data may contain duplicates or historical versions if the ingestion process performs full dumps rather than incremental updates.