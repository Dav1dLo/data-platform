# base_module_install_review

## Source system
This table originates from an Odoo ERP system. The naming convention `base_module_install_review` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal module management and review tracking framework.

## Functional process 
This table supports the module installation and review lifecycle within the ERP. It tracks administrative reviews or status updates associated with specific software modules installed in the environment, likely used to gate or audit the deployment of custom or third-party modules.

## Description
One row represents a single review record or status entry for a specific module installation. As a staging table, it serves as a raw, direct copy of the underlying Odoo database table, capturing the audit trail of who created or modified the review record and when.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_module_install_review_id_seq`. |
| module_id | INTEGER | false | Foreign key to the module | Identifies the specific software module being reviewed. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in the source system's local time. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in the source system's local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id` (Guess: Standard Odoo pattern for linking to the module registry).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are typically stored in the source system's local time; verify if the Odoo instance is configured for UTC.
- **Audit columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs; these will not resolve to names without joining against the `res_users` table.
- **Data volatility:** As a staging table, this data may be truncated and reloaded or updated frequently by the ingestion process.
- **Soft deletes:** Odoo tables often do not use soft-delete flags; records are typically hard-deleted from the source.