# stock_valuation_layer

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `categ_id`, `create_uid`, `write_uid`, `account_move_id`) and the specific structure of stock valuation layers are characteristic of Odoo's inventory and accounting modules.

## Functional process 
This table supports the inventory valuation and cost accounting process. It tracks the financial impact of stock movements, linking physical inventory changes (`stock_move_id`) to accounting entries (`account_move_id`) and maintaining the valuation of specific product lots over time.

## Description
One row in this table represents a single valuation layer entry for a specific product, recording the quantity and financial value associated with a stock movement. As a staging table, it serves as a raw, landed copy of the Odoo `stock.valuation.layer` model, capturing the state of inventory costs at the time of a transaction.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_valuation_layer_id_seq`. |
| company_id | INTEGER | false | ID of the associated company | Links to the multi-company structure. |
| product_id | INTEGER | false | ID of the product | Foreign key to the product master. |
| categ_id | INTEGER | true | ID of the product category | Used for grouping valuation rules. |
| stock_valuation_layer_id | INTEGER | true | Parent valuation layer ID | Used for hierarchical valuation tracking. |
| stock_move_id | INTEGER | true | ID of the source stock move | Links to the physical inventory movement. |
| account_move_id | INTEGER | true | ID of the accounting entry | Links to the general ledger entry. |
| account_move_line_id | INTEGER | true | ID of the accounting move line | Specific line item in the journal entry. |
| lot_id | INTEGER | true | ID of the product lot/serial | Tracks valuation at the lot level. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for record creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail for record updates. |
| description | VARCHAR | true | Descriptive text for the entry | Often contains reference to the move. |
| quantity | NUMERIC | true | Quantity moved | Positive for incoming, negative for outgoing. |
| unit_cost | NUMERIC | true | Cost per unit | The valuation cost applied to this move. |
| value | NUMERIC | true | Total value of the move | Calculated as quantity * unit_cost. |
| remaining_qty | NUMERIC | true | Remaining quantity in stock | Snapshot of stock level after this move. |
| remaining_value | NUMERIC | true | Remaining value in stock | Snapshot of financial value after this move. |
| create_date | TIMESTAMP | true | Record creation timestamp | Typically UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Typically UTC. |
| price_diff_value | DOUBLE PRECISION | true | Price difference value | Used for accounting variance adjustments. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `product_id` → `product_product.id` (Standard Odoo link to product master)
    - `stock_move_id` → `stock_move.id` (Links to the physical movement record)
    - `account_move_id` → `account_move.id` (Links to the financial journal entry)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployment practices.
- **Data Integrity:** This is a raw staging table; it may contain multiple entries per product that must be aggregated or filtered by date to determine current stock valuation.
- **Precision:** `quantity` and `value` fields use `NUMERIC` types, which are appropriate for financial calculations, but ensure rounding logic is applied consistently in downstream transformations.
- **Soft Deletes:** Odoo typically does not use soft deletes for valuation layers; records are generally immutable once posted to the ledger.