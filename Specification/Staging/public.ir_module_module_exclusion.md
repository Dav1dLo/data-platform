# ir_module_module_exclusion

## Source system
This table originates from an Odoo ERP system, as indicated by the `ir_module_module_exclusion` naming convention and the use of `ir_` (Internal Resource) prefixes, which are standard for Odoo's metadata and module management tables.

## Functional process 
This table supports the Odoo module management system, specifically tracking dependency exclusions or conflicts between different software modules. It ensures that incompatible modules are not installed or activated simultaneously within the ERP environment.

## Description
One row in this table represents a specific exclusion rule defined for a module, identifying which other module or component is incompatible. As a staging table, it serves as a raw, direct copy of the Odoo internal metadata, capturing the state of module constraints at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique surrogate primary key | Uses sequence `ir_module_module_exclusion_id_seq`. |
| module_id | INTEGER | true | Foreign key to the module being restricted | References `ir_module_module`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| name | VARCHAR | true | Name or description of the exclusion rule | Likely contains a human-readable identifier or constraint string. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id`: Links the exclusion rule to the specific module it applies to.
    - `create_uid` → `res_users.id`: Links to the user who performed the creation.
    - `write_uid` → `res_users.id`: Links to the user who performed the last update.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit fields (`create_uid`, `write_uid`) which are standard in Odoo for tracking record provenance.
- The `name` column may contain varying formats depending on the specific Odoo version's implementation of module constraints.
- No soft-delete flag is present; assume standard CRUD operations apply to this table.