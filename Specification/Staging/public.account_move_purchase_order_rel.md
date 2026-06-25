# account_move_purchase_order_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `account_move_purchase_order_rel` is a standard pattern used by Odoo to represent a many-to-many relationship table (often referred to as a "relation" table) linking accounting journal entries (`account_move`) to procurement documents (`purchase_order`).

## Functional process 
This table supports the Procure-to-Pay (P2P) business process by maintaining the link between purchase orders and their corresponding accounting entries (invoices or vendor bills). It ensures traceability between the commitment of funds in the procurement module and the financial recognition in the accounting module.

## Description
One row in this table represents a single association between a specific purchase order and an accounting move. It serves as a raw landing copy of the join table used to resolve many-to-many relationships between the purchasing and accounting modules in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_id | INTEGER | false | Foreign key to the purchase order record. | References the primary key of the purchase order table. |
| account_move_id | INTEGER | false | Foreign key to the accounting move record. | References the primary key of the account move table. |

## Keys

- **Primary key (inferred):** The composite of (`purchase_order_id`, `account_move_id`).
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `purchase_order.id`: Links to the source purchase order document.
    - `account_move_id` → `account_move.id`: Links to the source accounting journal entry.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it reflects the current state of the relationship as captured during the last ingestion.
- Ensure that joins to the target tables handle potential orphans if the source system performs hard deletes on parent records.