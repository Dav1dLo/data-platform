# stock_conflict_quant_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular inventory management system. The naming convention `stock_conflict_quant_rel` strongly suggests a join table used to manage many-to-many relationships between inventory conflict events and specific stock quant records.

## Functional process 
This table supports the inventory reconciliation and conflict resolution process. It maps specific stock quantity records (`stock_quant_id`) that are currently involved in or flagged by a specific inventory conflict event (`stock_conflict_inventory_id`), allowing the system to track which items are affected by a discrepancy.

## Description
One row in this table represents a single association between an inventory conflict record and a specific stock quantity record. As a staging table, it serves as a raw, normalized link entity representing the many-to-many relationship between conflict events and inventory quants.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_conflict_id | INTEGER | false | Foreign key to the inventory conflict event. | Links to the parent conflict record. |
| stock_quant_id | INTEGER | false | Foreign key to the specific stock quantity record. | Identifies the specific inventory item involved. |

## Keys

- **Primary key (inferred):** Composite key of (`stock_inventory_conflict_id`, `stock_quant_id`).
- **Foreign keys (inferred):** 
    - `stock_inventory_conflict_id` → `stock_inventory_conflict.id` (Inferred based on naming convention).
    - `stock_quant_id` → `stock_quant.id` (Inferred based on naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect it to be used primarily in `JOIN` operations between conflict and quant tables.
- There are no timestamps or audit columns present; this table represents the current state of associations as captured during the last ingestion.
- Ensure that joins are performed on both columns to maintain referential integrity, as neither column is likely unique on its own.