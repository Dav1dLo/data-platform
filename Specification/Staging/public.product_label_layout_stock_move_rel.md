# product_label_layout_stock_move_rel

## Source system
The table likely originates from an Odoo or similar ERP system, as indicated by the naming convention `_rel` (common for many-to-many relationship tables) and the specific pairing of `product_label_layout` and `stock_move` entities.

## Functional process 
This table supports the inventory and logistics management process, specifically linking product label printing configurations to specific stock movement events. It facilitates the tracking of which label layouts were applied or associated with individual inventory transfers.

## Description
One row in this table represents a single association between a product label layout and a stock move. It serves as a raw junction table in the staging layer, enabling a many-to-many relationship between label configurations and inventory movement records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_label_layout_id | INTEGER | false | Foreign key to the product label layout definition | Links to the configuration entity |
| stock_move_id | INTEGER | false | Foreign key to the stock move record | Links to the inventory movement entity |

## Keys

- **Primary key (inferred):** The composite of (`product_label_layout_id`, `stock_move_id`).
- **Foreign keys (inferred):** 
    - `product_label_layout_id` → `product_label_layout.id`: This column references the layout definition used for printing.
    - `stock_move_id` → `stock_move.id`: This column references the specific inventory movement event.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this with both the `product_label_layout` and `stock_move` tables to retrieve meaningful business data.
- There are no timestamps or audit columns; the creation time of these relationships is not explicitly tracked in this table.
- The table contains no PII or sensitive data.