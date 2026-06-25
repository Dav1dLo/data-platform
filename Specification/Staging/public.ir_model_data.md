# ir_model_data

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_model_data` is a core Odoo internal table used to track external identifiers for database records, which is a hallmark of the Odoo framework's data architecture.

## Functional process 
This table supports the Odoo module management and data migration process. It maps "External IDs" (human-readable identifiers like `module.name`) to internal database surrogate keys (`res_id`), allowing the system to maintain references to records across different database instances or module updates.

## Description
One row in this table represents a mapping between an external identifier (defined by a module and a name) and a specific record within a target model. As a staging table, it provides a raw, direct copy of the Odoo `ir_model_data` system table, serving as the foundation for resolving cross-references in downstream data models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Internal surrogate primary key | Uses sequence `ir_model_data_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Creation timestamp | Defaults to UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Defaults to UTC. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| res_id | INTEGER | true | Target record ID | The ID of the record in the table specified by `model`. |
| noupdate | BOOLEAN | true | Prevent update flag | If true, prevents the record from being overwritten during module upgrades. |
| name | VARCHAR | false | External identifier name | The unique name part of the external ID. |
| module | VARCHAR | false | Module name | The module that owns this external identifier. |
| model | VARCHAR | false | Target model name | The Odoo model (table) the record belongs to. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** 
    - `(module, name)`: This combination forms the unique "External ID" used by Odoo to identify records across environments.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be linked to employee names in other tables.
- **Timezone:** Timestamps are stored in UTC.
- **Soft Deletes:** This table does not implement soft deletes; it is a system-level mapping table where records are typically permanent unless the module is uninstalled.
- **Usage:** When joining to other tables, always filter by `model` to ensure the `res_id` is joined against the correct target table.