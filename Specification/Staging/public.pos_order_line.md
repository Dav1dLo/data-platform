# pos_order_line

## Source system
This table originates from an Odoo ERP system, evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the sequence-based default value for the primary key.

## Functional process 
This table supports the Point of Sale (POS) retail transaction process. It captures the granular details of individual items added to a sales order, including pricing, quantities, discounts, and links to parent combo items or original sales orders.

## Description
One row represents a single line item within a point-of-sale order, detailing the product sold, its pricing, and quantity. As a staging table, it serves as a raw, direct reflection of the Odoo `pos.order.line` model, intended for ingestion into downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_order_line_id_seq`. |
| company_id | INTEGER | true | Identifier for the company | Multi-company support. |
| product_id | INTEGER | false | Product identifier | Foreign key to product master. |
| order_id | INTEGER | false | Parent POS order identifier | Links to the header record. |
| refunded_orderline_id | INTEGER | true | Reference to original line | Used for returns/refunds. |
| combo_parent_id | INTEGER | true | Parent combo identifier | Used for grouped product items. |
| combo_item_id | INTEGER | true | Combo item identifier | Specific item within a combo. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail. |
| name | VARCHAR | false | Line description | Often contains product name/variant. |
| notice | VARCHAR | true | Internal notice | Optional line-level notes. |
| price_type | VARCHAR | true | Pricing strategy | e.g., fixed, percentage. |
| full_product_name | VARCHAR | true | Expanded product name | Includes variants/attributes. |
| customer_note | VARCHAR | true | Note for the customer | Printed on receipts. |
| uuid | VARCHAR | true | Global unique identifier | Used for synchronization. |
| note | VARCHAR | true | General line note | Internal or external note. |
| price_unit | NUMERIC | true | Unit price | Price per single unit. |
| qty | NUMERIC | true | Quantity sold | Decimal allows for fractional units. |
| price_subtotal | NUMERIC | false | Subtotal excluding tax | Calculated value. |
| price_subtotal_incl | NUMERIC | false | Subtotal including tax | Calculated value. |
| total_cost | NUMERIC | true | Total cost of goods sold | Used for margin analysis. |
| discount | NUMERIC | true | Discount percentage | Applied to the line. |
| skip_change | BOOLEAN | true | Skip change flag | POS-specific logic. |
| is_total_cost_computed | BOOLEAN | true | Cost calculation status | Flag for cost accuracy. |
| is_edited | BOOLEAN | true | Manual edit flag | Indicates if price/qty was changed. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| price_extra | DOUBLE PRECISION | true | Additional price | Extra charges for variants. |
| sale_order_origin_id | INTEGER | true | Originating sales order ID | Links to e-commerce/sales. |
| sale_order_line_id | INTEGER | true | Originating sales order line ID | Links to e-commerce/sales. |
| down_payment_details | TEXT | true | Down payment info | JSON or text blob. |
| qty_delivered | DOUBLE PRECISION | true | Quantity fulfilled | Used for inventory tracking. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `pos_order.id` (Links line to the parent transaction header).
    - `product_id` → `product_product.id` (Links line to the specific product catalog item).
- **Natural keys (inferred):** 
    - `uuid` (Used by Odoo for cross-system synchronization).

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not implement a soft-delete flag; records are typically immutable once the order is finalized.
- **Calculated Fields:** `price_subtotal` and `price_subtotal_incl` are pre-calculated by the application; verify these against `price_unit * qty` if performing custom aggregations.
- **Sensitive Data:** `customer_note` may contain PII; ensure appropriate masking if exposing to non-authorized users.