# stock_move_created_purchase_line_rel

## Source system
The table likely originates from an Odoo ERP system. The naming convention `_rel` is characteristic of Odoo's many-to-many relationship tables, and the column names `move_id` (stock move) and `created_purchase_line_id` (purchase order line) are standard identifiers within the Odoo inventory and procurement modules.

## Functional process 
This table supports the procurement-to-inventory pipeline. It maintains the link between stock movements (the physical receipt of goods) and the specific purchase order lines that triggered those movements, ensuring traceability between supply chain orders and warehouse operations.

## Description
One row represents a single association between a stock movement record and a purchase order line record. It serves as a raw landing join table in the staging layer, facilitating the resolution of many-to-many relationships between inventory transactions and procurement documents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| created_purchase_line_id | INTEGER | false | Foreign key to the purchase order line | Links to the procurement source. |
| move_id | INTEGER | false | Foreign key to the stock move | Links to the inventory movement. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`created_purchase_line_id`, `move_id`).
- **Foreign keys (inferred):**
    - `created_purchase_line_id` → `purchase_order_line.id`: Guessed based on the Odoo naming convention for purchase line references.
    - `move_id` → `stock_move.id`: Guessed based on the Odoo naming convention for stock movement references.
- **Natural keys (inferred):** The combination of (`created_purchase_line_id`, `move_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `created_at`) available in this table to determine when the relationship was established.
- Ensure that joins to target tables handle potential orphans if the source system performs hard deletes on parent records.