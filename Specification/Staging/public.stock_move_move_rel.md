# stock_move_move_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `table_name_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (join tables) between two entities, specifically tracking the lineage or dependency between stock moves.

## Functional process 
This table supports the inventory management and supply chain process, specifically tracking the relationship between source stock moves and destination stock moves. It is used to map the flow of goods, such as linking a "delivery" stock move to the "picking" or "procurement" move that preceded it.

## Description
One row in this table represents a single link or dependency between two stock move records. It acts as a junction table to facilitate many-to-many relationships between stock moves, serving as a raw landing copy of the underlying database relationship for downstream transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| move_orig_id | INTEGER | false | Foreign key to the original stock move | Represents the source or preceding move in the chain. |
| move_dest_id | INTEGER | false | Foreign key to the destination stock move | Represents the target or subsequent move in the chain. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`move_orig_id`, `move_dest_id`).
- **Foreign keys (inferred):** 
    - `move_orig_id` → `stock_move.id`: This column references the originating stock move record.
    - `move_dest_id` → `stock_move.id`: This column references the destination stock move record.
- **Natural keys (inferred):** The combination of (`move_orig_id`, `move_dest_id`) acts as the unique business identifier for the relationship.

## Caveats for downstream consumers

- This is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns; lineage must be inferred from the related `stock_move` records.
- Ensure joins to the `stock_move` table are handled carefully to avoid fan-outs if a move has multiple origins or destinations.