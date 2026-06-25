# stock_backorder_confirmation_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `picking_id`) and the use of PostgreSQL sequences for primary keys are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports the inventory management and order fulfillment process, specifically tracking the confirmation of backordered items during the picking process. It links specific picking operations to backorder confirmation headers, determining whether items should be split into a backorder or processed as a final delivery.

## Description
One row in this table represents a single line item within a backorder confirmation event, linking a specific picking operation to a confirmation record. As a staging table, it acts as a raw, landed copy of the Odoo `stock.backorder.confirmation.line` model, capturing the state of backorder decisions at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `stock_backorder_confirmation_line_id_seq`. |
| backorder_confirmation_id | INTEGER | true | Foreign key to the parent confirmation header | Links to the main backorder confirmation record. |
| picking_id | INTEGER | true | Foreign key to the stock picking record | Identifies the specific picking operation being processed. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res.users` table. |
| to_backorder | BOOLEAN | true | Backorder decision flag | If true, the system will create a backorder for the remaining items. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `backorder_confirmation_id` → `stock_backorder_confirmation.id` (Inferred from naming convention).
    - `picking_id` → `stock_picking.id` (Inferred from naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit user IDs (`create_uid`, `write_uid`) which may need to be joined against a user dimension table for meaningful reporting.
- The `to_backorder` boolean is the primary business logic driver; null values should be treated as "false" or "unknown" depending on the specific Odoo version's handling of default values.
- As a staging table, this data reflects the raw state and may contain multiple versions of the same logical record if the source system performs updates.