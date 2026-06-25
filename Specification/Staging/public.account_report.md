# account_report

## Source system
This table originates from Odoo (ERP), as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized names, which are standard patterns in Odoo's ORM layer.

## Functional process 
This table supports the financial reporting configuration process within the accounting module. It defines the parameters, filters, and display settings for various financial reports (e.g., Balance Sheet, P&L) available to users, controlling how data is aggregated and presented in the UI.

## Description
One row in this table represents a single configuration profile for a financial report. It acts as a staging entity containing the raw settings and filter toggles that determine report behavior. The grain is one row per report definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_report_id_seq` |
| sequence | INTEGER | true | Display order index | Used for sorting reports in UI |
| root_report_id | INTEGER | true | Parent report reference | Self-referencing ID for hierarchy |
| country_id | INTEGER | true | Country scope | Links to country-specific reporting rules |
| load_more_limit | INTEGER | true | Pagination limit | Max records to load per view |
| prefix_groups_threshold | INTEGER | true | Grouping threshold | UI display setting |
| create_uid | INTEGER | true | Creator user ID | References system user |
| write_uid | INTEGER | true | Last modifier user ID | References system user |
| chart_template | VARCHAR | true | Chart of accounts template | Defines the accounting structure |
| availability_condition | VARCHAR | true | Visibility logic | Conditional display rule |
| integer_rounding | VARCHAR | true | Rounding method | Precision setting for report values |
| default_opening_date_filter | VARCHAR | true | Default date range | Initial filter state |
| currency_translation | VARCHAR | true | Currency conversion rule | Logic for multi-currency reports |
| filter_multi_company | VARCHAR | true | Multi-company filter mode | Configuration for company scope |
| filter_hide_0_lines | VARCHAR | true | Zero-line suppression | Toggle for empty rows |
| filter_hierarchy | VARCHAR | true | Hierarchy display mode | Toggle for tree-view expansion |
| filter_account_type | VARCHAR | true | Account type filter | Scope of accounts included |
| name | JSONB | false | Report display name | Multi-language support via JSON |
| active | BOOLEAN | true | Soft-delete flag | True if report is enabled |
| use_sections | BOOLEAN | true | Sectioning toggle | Enables report grouping |
| only_tax_exigible | BOOLEAN | true | Tax filter | Only show tax-exigible items |
| search_bar | BOOLEAN | true | Search bar visibility | UI toggle |
| filter_date_range | BOOLEAN | true | Date range filter | Toggle for date picker |
| filter_show_draft | BOOLEAN | true | Draft entry filter | Toggle for unposted entries |
| filter_unreconciled | BOOLEAN | true | Unreconciled filter | Toggle for reconciliation status |
| filter_unfold_all | BOOLEAN | true | Unfold all toggle | Default expansion state |
| filter_period_comparison | BOOLEAN | true | Period comparison | Toggle for time-based analysis |
| filter_growth_comparison | BOOLEAN | true | Growth comparison | Toggle for variance analysis |
| filter_journals | BOOLEAN | true | Journal filter | Toggle for journal selection |
| filter_analytic | BOOLEAN | true | Analytic filter | Toggle for analytic accounting |
| filter_partner | BOOLEAN | true | Partner filter | Toggle for partner grouping |
| filter_fiscal_position | BOOLEAN | true | Fiscal position filter | Toggle for tax mapping |
| filter_aml_ir_filters | BOOLEAN | true | AML filter | Toggle for line-item filters |
| filter_budgets | BOOLEAN | true | Budget filter | Toggle for budget comparison |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `root_report_id` → `account_report.id` (Self-referencing hierarchy)
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference)
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference)
    - `country_id` → `res_country.id` (Guess: standard Odoo country reference)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory for PII.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE`.
- **JSONB:** The `name` column is `JSONB`; use `name->>'en_US'` (or relevant key) to extract string values for reporting.