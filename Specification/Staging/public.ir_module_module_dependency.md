# ir_module_module_dependency

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_module_module_dependency` is characteristic of Odoo's internal registry (IR) tables, which manage module metadata and system dependencies within the application framework.

## Functional process 
This table supports the module management and dependency resolution process within the ERP. It tracks which modules must be installed or present for another module to function correctly, ensuring that the system's internal dependency graph is maintained during updates or installations.

## Description
Each row represents a single dependency relationship where one module requires another to be present in the system. This is a raw landing table in the staging layer, capturing the state of module dependencies as defined in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_module_module_dependency_id_seq`. |
| name | VARCHAR | true | Name of the dependency | Likely the technical name of the required module. |
| module_id | INTEGER | true | Foreign key to the parent module | References the module that holds this dependency. |
| auto_install_required | BOOLEAN | true | Auto-install flag | Indicates if the dependency is required for auto-installation; defaults to true. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id`: This column likely links to the parent module definition in the Odoo module registry.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `module_id` column is nullable, which may indicate orphaned records or dependencies not currently linked to a specific module in the staging extract.
- The `auto_install_required` column defaults to `true`, which should be accounted for when filtering for mandatory dependencies.
- This table represents a snapshot of the Odoo internal registry; ensure that the extraction process captures the full dependency tree if performing cross-module analysis.