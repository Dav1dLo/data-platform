# mrp_production_backorder_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_production_backorder_line`), the use of `create_uid`/`write_uid` for audit tracking, and the standard Odoo sequence pattern for the `id` column.

## Functional process 
This table supports the manufacturing execution process, specifically tracking backordered items within production orders. It links specific production backorder headers to the underlying production records, determining whether items should be flagged for backorder processing via the `to_backorder` boolean flag.

## Description
One row in this table represents a single line item associated with a manufacturing production backorder. It serves as a raw landed copy of the staging data, capturing the relationship between a backorder header and a production order at the grain of a single line entry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mrp_production_backorder_line_id_seq` |
| mrp_production_backorder_id | INTEGER | false | Foreign key to the backorder header | Links to the parent backorder record |
| mrp_production_id | INTEGER | false | Foreign key to the production order | Identifies the specific manufacturing order |
| create_uid | INTEGER | true | User ID who created the record | References the system user table |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table |
| to_backorder | BOOLEAN | true | Backorder status flag | Indicates if this line is marked for backorder |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mrp_production_backorder_id` → `mrp_production_backorder.id` (Inferred from naming convention)
    - `mrp_production_id` → `mrp_production.id` (Inferred from naming convention)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains audit fields (`create_uid`, `write_uid`) which may require joining to a user dimension table for human-readable names.
- The `to_backorder` flag is the primary business logic indicator; nulls should be treated as `false` depending on the specific Odoo version implementation.
- This is a staging table; it represents a raw snapshot and may contain duplicate updates if the ingestion process is not idempotent.