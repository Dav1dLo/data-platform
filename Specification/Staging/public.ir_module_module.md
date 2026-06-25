# ir_module_module

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_module_module` is a standard Odoo internal table name used to track installed and available application modules within the system's "Ir" (Irrelevant/Internal Registry) framework.

## Functional process 
This table supports the module management and application lifecycle process within the Odoo environment. It tracks the installation state, versioning, and metadata of various functional modules (e.g., Sales, Inventory, Accounting) that extend the core ERP platform, facilitating dependency management and system configuration.

## Description
One row in this table represents a single Odoo module installed or available in the system, identified by its technical name. This is a raw landing copy of the Odoo registry, capturing the module's current state, version, and descriptive metadata, serving as the primary source for auditing system extensions and feature availability.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | Creator user ID | References `res_users`. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| write_uid | INTEGER | true | Last updater user ID | References `res_users`. |
| website | VARCHAR | true | Module website URL | |
| summary | JSONB | true | Module summary | Localized content. |
| name | VARCHAR | false | Technical module name | Unique identifier for the module. |
| author | VARCHAR | true | Module author | |
| icon | VARCHAR | true | Icon path/data | |
| state | VARCHAR(16) | true | Installation state | e.g., 'installed', 'uninstalled', 'to upgrade'. |
| latest_version | VARCHAR | true | Current version string | |
| shortdesc | JSONB | true | Short description | Localized content. |
| category_id | INTEGER | true | Category ID | References `ir_module_category`. |
| description | JSONB | true | Full description | Localized content. |
| application | BOOLEAN | true | Is application flag | |
| demo | BOOLEAN | true | Demo data flag | |
| web | BOOLEAN | true | Web module flag | |
| license | VARCHAR(32) | true | License type | |
| sequence | INTEGER | true | Display sequence | |
| auto_install | BOOLEAN | true | Auto-install flag | |
| to_buy | BOOLEAN | true | Purchase required flag | |
| maintainer | VARCHAR | true | Module maintainer | |
| published_version | VARCHAR | true | Published version | |
| url | VARCHAR | true | External URL | |
| contributors | TEXT | true | List of contributors | |
| menus_by_module | TEXT | true | Associated menu definitions | |
| reports_by_module | TEXT | true | Associated report definitions | |
| views_by_module | TEXT | true | Associated view definitions | |
| module_type | VARCHAR | true | Type of module | |
| imported | BOOLEAN | true | Import status flag | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for audit fields).
    - `category_id` → `ir_module_category.id` (Inferred from the `_id` suffix).
- **Natural keys (inferred):** 
    - `name` (The technical name is the unique business identifier for a module in Odoo).

## Caveats for downstream consumers

- **Sensitive Data:** Contains no PII, but `summary`, `shortdesc`, and `description` are `JSONB` fields which may contain varying structures depending on the Odoo version.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically uses the `state` column to manage lifecycle rather than physical deletion; rows are rarely deleted from this table.
- **Data Complexity:** The `*_by_module` columns contain serialized text (often XML or JSON strings) representing complex system configurations; parsing these requires specific Odoo-aware logic.