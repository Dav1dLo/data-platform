# website_configurator_feature

## Source system
This table originates from an Odoo ERP instance, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for multi-language fields (`name`, `description`). The `iap_page_code` and `website_config_preselection` columns further suggest integration with Odoo's In-App Purchase (IAP) and website builder modules.

## Functional process 
This table supports the website configuration and navigation structure process. It manages the definition and ordering of features or modules available within the website configurator, likely used to drive the UI components or menu items presented to users during the website setup or customization flow.

## Description
One row in this table represents a single configurable feature or menu item within the website builder interface. It acts as a raw landed copy of the Odoo configuration entity, capturing metadata, display labels, and sequence ordering for features. The grain is one row per feature definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `website_configurator_feature_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for sorting features in the UI. |
| page_view_id | INTEGER | true | Foreign key to page view | Links to the associated page view definition. |
| module_id | INTEGER | true | Foreign key to module | Links to the specific software module. |
| menu_sequence | INTEGER | true | Menu display order | Specific sequence for menu-based items. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | References the user who last modified the record. |
| icon | VARCHAR | true | Icon identifier | CSS class or path for the feature icon. |
| iap_page_code | VARCHAR | true | IAP service code | Identifier for In-App Purchase related features. |
| website_config_preselection | VARCHAR | true | Preselection flag | Indicates if this feature is selected by default. |
| feature_url | VARCHAR | true | Target URL | The destination link for the feature. |
| name | JSONB | true | Localized feature name | Multilingual JSON object. |
| description | JSONB | true | Localized description | Multilingual JSON object. |
| menu_company | BOOLEAN | true | Company menu flag | Indicates if the feature is company-specific. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `page_view_id` → `website_page_view.id` (guess: standard Odoo naming convention for page views).
    - `module_id` → `ir_module_module.id` (guess: standard Odoo reference to installed modules).
    - `create_uid` → `res_users.id` (guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` and `description` columns contain JSONB data; ensure you use the `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal Odoo user IDs; these may not map to external identity systems without a join to the `res_users` table.
- **Data Integrity:** As a staging table, this may contain historical versions or incomplete configurations; verify if filtering by `write_date` is required for the latest state.