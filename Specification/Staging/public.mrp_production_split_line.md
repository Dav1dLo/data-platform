# mrp_production_split_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_production_split_line`), the use of `create_uid`/`write_uid` audit columns, and the sequence-based default value for the primary key.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the splitting of production orders. It records the breakdown of quantities across different production lines or time slots, likely used to manage partial completions or batch splits within the manufacturing resource planning (MRP) module.

## Description
One row in this table represents a single line item within a production split event, detailing the quantity allocated to that specific split. As a staging table, it serves as a raw, direct ingestion of the Odoo `mrp.production.split.line` model, capturing the state of production splits at the time of extraction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| mrp_production_split_id | INTEGER | false | Foreign key to parent split | Links to the header record in `mrp_production_split`. |
| user_id | INTEGER | true | Responsible user ID | The user associated with this specific split line. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| quantity | NUMERIC | false | Split quantity | The amount of product allocated to this split line. |
| date | TIMESTAMP | true | Scheduled date | The planned date for this specific split line. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Last modification time in the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mrp_production_split_id` → `mrp_production_split.id`: This column links the line item to its parent production split header.
    - `create_uid` / `write_uid` / `user_id` → `res_users.id`: These columns typically reference the Odoo user directory.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`user_id`, `create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are current unless filtered by business logic.
- **Data Integrity:** As a staging table, ensure that `quantity` is validated for non-negative values before performing aggregations.