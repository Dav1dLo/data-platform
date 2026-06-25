# spreadsheet_dashboard

## Source system
This table originates from an Odoo ERP environment. The presence of columns like `create_uid`, `write_uid`, `create_date`, and `write_date` following the standard Odoo audit trail pattern, combined with the `JSONB` type for the `name` field (often used for multi-language translations in Odoo), strongly indicates an Odoo backend.

## Functional process 
This table supports the "Spreadsheet Dashboard" management module within the ERP. It tracks the configuration and organization of custom dashboard views, managing their grouping, display sequence, and publication status for specific companies.

## Description
One row represents a single spreadsheet dashboard configuration record. It serves as a raw landed staging entity, capturing the metadata required to render or manage dashboard layouts within the application. The grain is one row per dashboard definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.spreadsheet_dashboard_id_seq` |
| dashboard_group_id | INTEGER | false | Foreign key to the dashboard group | Links to the parent category or group |
| sequence | INTEGER | true | Display order index | Used for sorting dashboards in the UI |
| company_id | INTEGER | true | Owning company identifier | Multi-tenant identifier for the dashboard |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` table |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users` table |
| sample_dashboard_file_path | INTEGER | true | Path to the dashboard template file | Likely a relative path to a storage bucket |
| name | JSONB | false | Dashboard name | Likely contains localized strings |
| is_published | BOOLEAN | true | Publication status flag | Determines visibility in the dashboard list |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dashboard_group_id` → `spreadsheet_dashboard_group.id` (Inferred from naming convention)
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company isolation)
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail pattern)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; ensure you use the `->>` operator to extract text values for reporting (e.g., `name->>'en_US'`).
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not appear to implement soft-delete; assume rows are hard-deleted if they disappear from the source.
- `is_published` may be null; treat nulls as `false` for business logic purposes.