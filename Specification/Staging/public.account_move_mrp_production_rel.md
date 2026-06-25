# account_move_mrp_production_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `account_move_mrp_production_rel` follows the standard Odoo pattern for a many-to-many join table linking accounting entries (`account_move`) to manufacturing production orders (`mrp_production`).

## Functional process 
This table supports the manufacturing-to-finance integration process. It tracks the relationship between specific manufacturing production orders and the corresponding accounting journal entries generated during the production lifecycle, such as the consumption of raw materials or the valuation of finished goods.

## Description
One row represents a single link between an accounting move and a manufacturing production order. It serves as a raw, junction-table copy in the staging layer, facilitating the reconstruction of relationships between financial records and production activities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_id | INTEGER | false | Foreign key to the accounting move record | Links to the financial ledger entry. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order | Links to the production order record. |

## Keys

- **Primary key (inferred):** The composite of (`account_move_id`, `mrp_production_id`).
- **Foreign keys (inferred):** 
    - `account_move_id` → `account_move.id`: This column references the primary key of the accounting move table.
    - `mrp_production_id` → `mrp_production.id`: This column references the primary key of the manufacturing production order table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns; assume this table is a snapshot of the current state of relationships in the source system.
- Ensure joins are performed on both columns to maintain referential integrity, as neither column is guaranteed to be unique on its own.