# stock_move_line_consume_rel

## Source system
The table likely originates from an ERP system such as Odoo, where the naming convention `_rel` and the pairing of `consume_line_id` and `produce_line_id` are characteristic of many-to-many relationship tables used to track inventory consumption against production orders.

## Functional process 
This table supports the manufacturing and inventory management process, specifically linking raw material consumption lines to the finished goods production lines they support. It facilitates the traceability of components used in specific production batches.

## Description
One row in this table represents a single link between a specific inventory consumption move line and a production move line. It serves as a raw landing join table in the staging layer to maintain the many-to-many relationship between material usage and production output.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| consume_line_id | INTEGER | false | Foreign key to the consumption move line | Represents the component being used. |
| produce_line_id | INTEGER | false | Foreign key to the production move line | Represents the finished or semi-finished product. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`consume_line_id`, `produce_line_id`).
- **Foreign keys (inferred):** 
    - `consume_line_id` → `stock_move_line.id` (Guess: links to the inventory movement record for the consumed item).
    - `produce_line_id` → `stock_move_line.id` (Guess: links to the inventory movement record for the produced item).
- **Natural keys (inferred):** The combination of (`consume_line_id`, `produce_line_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this against the source `stock_move_line` table to retrieve meaningful attributes like product names or quantities.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on this table for change detection.
- The table does not contain soft-delete flags; assume that the absence of a record implies the relationship does not exist or has been removed.