# stock_return_picking_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`stock_return_picking_line`), the use of `wizard_id` (common in Odoo's transient models), and the standard audit columns `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the inventory return process, specifically tracking individual line items selected for return during a stock picking reversal. It captures the quantity of products being returned and whether those items are flagged for financial refund, facilitating the link between physical inventory movements and accounting adjustments.

## Description
One row represents a single line item within a stock return wizard, detailing the quantity of a specific product being returned for a given picking operation. As a staging table, it provides a raw, transactional view of return requests before they are processed into final stock moves or accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_return_picking_line_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | References the product being returned. |
| wizard_id | INTEGER | true | Foreign key to return wizard | Links to the parent return wizard session. |
| move_id | INTEGER | true | Foreign key to stock move | References the original stock move being returned. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the return line. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the line. |
| quantity | NUMERIC | false | Return quantity | The amount of product to be returned. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |
| to_refund | BOOLEAN | true | Refund flag | Indicates if the returned item should trigger a financial refund. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: standard Odoo product reference).
    - `wizard_id` → `stock_return_picking.id` (Guess: links to the parent return wizard).
    - `move_id` → `stock_move.id` (Guess: links to the specific inventory movement being reversed).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's standard database configuration.
- The table does not explicitly show a soft-delete flag; assume rows are hard-deleted if removed from the source.
- `to_refund` may be null; treat nulls as `false` for business logic purposes unless otherwise specified by the source application.
- This table is a transient/staging entity; data may be volatile depending on the lifecycle of the associated `wizard_id`.