# stock_inventory_conflict

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the `id` column are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports inventory management and reconciliation processes. It tracks conflicts or discrepancies that arise during stock inventory counts or adjustments, likely serving as an audit or exception log for warehouse operations where physical stock levels do not match system records.

## Description
One row in this table represents a single inventory conflict event or discrepancy record. As a staging table, it provides a raw, landed copy of the conflict data from the source ERP, intended for subsequent transformation into analytical inventory models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_inventory_conflict_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| create_date | TIMESTAMP | true | Creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit columns:** `create_uid` and `write_uid` are likely internal system IDs; they may not be human-readable without joining to a user metadata table.
- **Data completeness:** As a staging table, this may contain transient or incomplete records; ensure filtering by `create_date` if performing time-series analysis.
- **Soft deletes:** This table does not explicitly show a `deleted` or `active` flag; assume all records are current unless business logic dictates otherwise.