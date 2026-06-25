# ir_exports

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `ir_` prefixes are characteristic of Odoo's internal "ir" (Irregular/Internal Resource) module architecture, which manages system-level configurations and exports.

## Functional process 
This table supports the data export management process within the ERP. It tracks the configuration and metadata of export templates or definitions used to extract data from the system, linking specific resources to user-defined export formats.

## Description
One row in this table represents a single export definition or template record created within the system. It serves as a raw landed copy of the Odoo `ir.exports` model, capturing the audit trail of who created or modified the export configuration and the associated resource type.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.ir_exports_id_seq`. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system's user table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system's user table. |
| name | VARCHAR | true | Export name | Descriptive label for the export template. |
| resource | VARCHAR | true | Target resource model | The internal Odoo model name (e.g., 'res.partner') being exported. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `create_uid` and `write_uid` columns link to user identities; ensure access is restricted if user PII is exposed in the corresponding user table.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a boolean `active` flag, which is common in Odoo; assume all records are currently active unless otherwise specified by business logic.
- **Data Integrity:** As a staging table, this represents a raw snapshot; verify if the `resource` column contains valid model names before joining against other system tables.