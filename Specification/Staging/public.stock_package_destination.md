# stock_package_destination

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `picking_id`, `create_uid`, `write_uid`, `write_date`) and the use of sequence-based primary keys are characteristic of Odoo's PostgreSQL-based backend architecture.

## Functional process 
This table supports the inventory management and logistics pipeline, specifically tracking the destination locations for stock packages associated with picking operations. It links specific inventory movements (pickings) to their intended physical or logical destination locations within the warehouse structure.

## Description
One row in this table represents the assignment of a destination location to a specific stock package within a picking operation. This is a raw landed copy of the staging data, serving as a link table between inventory pickings and destination warehouse locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.stock_package_destination_id_seq` |
| picking_id | INTEGER | false | Foreign key to the picking operation | Links to the parent stock picking record |
| location_dest_id | INTEGER | false | Foreign key to the destination location | Identifies the target warehouse location |
| create_uid | INTEGER | true | User ID who created the record | References the system user table |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table |
| create_date | TIMESTAMP | true | Creation timestamp | Likely in UTC |
| write_date | TIMESTAMP | true | Last update timestamp | Likely in UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `picking_id` → `stock_picking.id` (Inferred from Odoo naming conventions for picking operations).
    - `location_dest_id` → `stock_location.id` (Inferred from Odoo naming conventions for warehouse locations).
    - `create_uid` → `res_users.id` (Standard Odoo audit column pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table does not contain soft-delete flags; assume records are hard-deleted if removed from the source.
- The `create_uid` and `write_uid` columns may be null if the record was created via a system process rather than a specific user action.
- Ensure joins to `picking_id` and `location_dest_id` account for potential missing records in the target tables if referential integrity is not strictly enforced at the database level.