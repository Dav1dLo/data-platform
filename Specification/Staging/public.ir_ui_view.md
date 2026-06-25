# ir_ui_view

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_ui_view` (Internal Resource User Interface View) and the presence of columns like `arch_db`, `inherit_id`, and `model` are characteristic of Odoo's metadata-driven view architecture.

## Functional process 
This table supports the Odoo UI rendering engine, managing the definitions of views (forms, lists, kanban, etc.) used across the application. It tracks how views are inherited, their priority in the rendering stack, and their association with specific business models or website themes.

## Description
One row represents a single UI view definition or customization within the Odoo framework. It stores the XML-based architecture (in `arch_db`), inheritance logic, and metadata for rendering user interfaces. This is a raw landed copy of the Odoo system table, serving as the primary source for UI structure and website-specific view configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| priority | INTEGER | false | Rendering priority | Lower numbers usually indicate higher priority. |
| inherit_id | INTEGER | true | Parent view ID | References another view if this is an extension. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | VARCHAR | false | View name | Descriptive label for the view. |
| model | VARCHAR | true | Associated model | The Odoo business object this view belongs to. |
| key | VARCHAR | true | Unique view key | Used for programmatic lookup of specific views. |
| type | VARCHAR | true | View type | e.g., 'form', 'tree', 'kanban', 'qweb'. |
| arch_fs | VARCHAR | true | File system path | Path to the view file if defined on disk. |
| mode | VARCHAR | false | View mode | 'primary' or 'extension'. |
| arch_db | JSONB | true | View architecture | The actual XML/JSON structure of the UI. |
| arch_prev | TEXT | true | Previous architecture | Backup of the previous view definition. |
| arch_updated | BOOLEAN | true | Update flag | Indicates if the architecture has been modified. |
| active | BOOLEAN | true | Active status | Soft-delete flag. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Modification timestamp | UTC timestamp of last update. |
| customize_show | BOOLEAN | true | Customization visibility | Flag for UI customization features. |
| website_id | INTEGER | true | Website ID | Links the view to a specific website instance. |
| theme_template_id | INTEGER | true | Theme template ID | Links the view to a specific website theme. |
| website_meta_og_img | VARCHAR | true | Open Graph image URL | SEO metadata for social sharing. |
| visibility | VARCHAR | true | Visibility setting | Access control level for the view. |
| visibility_password | VARCHAR | true | Visibility password | Password required to access the view. |
| website_meta_title | JSONB | true | SEO Title | Localized SEO title metadata. |
| website_meta_description | JSONB | true | SEO Description | Localized SEO description metadata. |
| website_meta_keywords | JSONB | true | SEO Keywords | Localized SEO keywords metadata. |
| seo_name | JSONB | true | SEO Name | Localized SEO-friendly name. |
| track | BOOLEAN | true | Tracking enabled | Whether view usage is tracked for analytics. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `inherit_id` → `ir_ui_view.id`: References the parent view for inheritance.
    - `create_uid` → `res_users.id`: References the user who created the record (guess).
    - `write_uid` → `res_users.id`: References the user who last modified the record (guess).
    - `website_id` → `website.id`: Links to the website configuration (guess).
- **Natural keys (inferred):** `name` (in combination with `model` and `type` often acts as a business key).

## Caveats for downstream consumers

- **Sensitive Data:** `visibility_password` may contain plain-text or hashed passwords; ensure access is restricted.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE`.
- **JSONB Complexity:** `arch_db` and SEO-related columns contain nested JSONB data; ensure your SQL dialect supports JSONB path extraction for analysis.