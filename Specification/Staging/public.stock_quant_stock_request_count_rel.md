# stock_quant_stock_request_count_rel

## Source system
The table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables (junction tables) between two entities, in this case, `stock_quant` and `stock_request_count`.

## Functional process 
This table supports inventory management and stock request fulfillment processes. It acts as a link between specific stock quant records (representing physical inventory quantities in a location) and stock request counts, facilitating the tracking of which inventory quant is associated with which request count.

## Description
One row in this table represents a single association between a stock quant and a stock request count. It is a raw landed junction table in the staging layer, used to resolve the many-to-many relationship between inventory records and request tracking entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_request_count_id | INTEGER | false | Foreign key to the stock request count entity | Represents the identifier for the request count record. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant entity | Represents the identifier for the specific inventory quant. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This table likely uses a composite primary key consisting of both `stock_request_count_id` and `stock_quant_id`.
- **Foreign keys (inferred):** 
    - `stock_request_count_id` → `stock_request_count.id` (Inferred from Odoo naming conventions).
    - `stock_quant_id` → `stock_quant.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** The combination of (`stock_request_count_id`, `stock_quant_id`) acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; queries should expect to perform `JOIN` operations on both columns to retrieve meaningful business data.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- As a staging table, it may contain orphaned records if the upstream source system does not enforce strict referential integrity during the landing process.