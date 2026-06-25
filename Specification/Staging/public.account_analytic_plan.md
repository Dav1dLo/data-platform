# account_analytic_plan

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for localized fields like `name`. The schema structure is consistent with Odoo's analytic accounting module.

## Functional process 
This table supports the analytic accounting framework, specifically the definition of analytic plans used to categorize and track financial transactions across different dimensions (e.g., projects, departments, or cost centers). It manages the hierarchical structure of these plans, allowing for nested categorization via `parent_id` and `parent_path`.

## Description
One row represents a single analytic plan or sub-plan within the organization's accounting structure. This is a raw landing table in the staging layer, containing the direct state of the analytic plan configuration as defined in the source ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| parent_id | INTEGER | true | Self-referencing foreign key to the parent plan | Defines the hierarchy of plans. |
| color | INTEGER | true | UI color index | Used for visual categorization in the ERP interface. |
| sequence | INTEGER | true | Display order index | Determines the sort order in UI lists. |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the users table. |
| parent_path | VARCHAR | true | Materialized path for tree traversal | Used for efficient hierarchical queries. |
| complete_name | VARCHAR | true | Full hierarchical name of the plan | Denormalized string for display purposes. |
| name | JSONB | false | Localized name of the plan | Stores translations; typically keyed by language code. |
| default_applicability | JSONB | true | Default configuration settings | Stores JSON-encoded applicability rules. |
| description | TEXT | true | Detailed description of the plan | Free-text field. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `account_analytic_plan.id`: Establishes the parent-child relationship for the plan hierarchy.
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **JSONB Handling:** The `name` and `default_applicability` columns contain JSONB data; query writers must use PostgreSQL JSON operators (e.g., `->>`) to extract values.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted_at` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Hierarchy:** Use the `parent_path` column for efficient recursive queries rather than self-joining on `parent_id` where possible.