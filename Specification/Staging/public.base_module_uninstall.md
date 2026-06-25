# base_module_uninstall

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention `base_module_uninstall` and the standard Odoo audit columns `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the module management lifecycle within the ERP, specifically tracking the uninstallation process of software modules. It records which modules were flagged for removal and the administrative metadata associated with those actions.

## Description
One row in this table represents a single uninstallation request or event for a specific software module within the system. As a staging table, it serves as a raw, landed copy of the operational uninstallation log, preserving the state of the module removal process for downstream audit or reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_module_uninstall_id_seq`. |
| module_id | INTEGER | false | Foreign key to the module being uninstalled | References the internal module registry. |
| create_uid | INTEGER | true | User ID who initiated the uninstallation | References `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users` table. |
| show_all | BOOLEAN | true | Flag for visibility settings | Likely determines if dependencies are shown. |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id` (Inferred from Odoo standard naming for module references).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which link to internal system users; ensure these are handled according to internal access policies.
- **Timezones:** Timestamps are typically stored in UTC in Odoo-based systems.
- **Data Integrity:** As a staging table, this may contain multiple entries for the same `module_id` if the uninstallation process was retried or modified; check `write_date` for the most recent state.
- **Soft Deletes:** This table does not appear to use a soft-delete flag; it represents the history of uninstallation events.