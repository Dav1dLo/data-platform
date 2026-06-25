# ir_exports_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `ir_exports_line`, `create_uid`, `write_uid`, `create_date`) is characteristic of the Odoo framework's internal registry (`ir` prefix) for managing data export configurations and their associated line items.

## Functional process 
This table supports the configuration of data export templates within the ERP. It stores the individual line items or fields defined within a specific export definition, allowing users to map specific database fields to columns in an exported file (such as CSV or Excel).

## Description
One row in this table represents a single field or column definition associated with a specific data export configuration. It acts as a raw landing copy of the Odoo `ir.exports.line` model, capturing the structural metadata required to generate export files.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_exports_line_id_seq`. |
| export_id | INTEGER | true | Foreign key to the parent export definition | Links to the `ir_exports` table. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users` table. |
| name | VARCHAR | true | The field name or path being exported | Likely contains the technical field name. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `export_id` → `ir_exports.id` (Inferred from naming convention and Odoo architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user tables to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Lifecycle:** This is a staging table; it represents a snapshot of the configuration and does not contain business transaction data, but rather the metadata for how data is extracted.
- **Nullability:** Many fields are nullable; ensure joins account for potential missing references in the source system.