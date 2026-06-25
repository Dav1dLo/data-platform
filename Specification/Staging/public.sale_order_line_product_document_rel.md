# sale_order_line_product_document_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `_rel` is a standard pattern used by Odoo's ORM to represent many-to-many relationship tables that link two distinct entities (in this case, sale order lines and product documents).

## Functional process 
This table supports the document management process within the sales pipeline. It acts as a bridge to associate specific product-related documentation (such as manuals, safety sheets, or technical specifications) with individual line items on a sales order, ensuring that the correct collateral is linked to the items being sold.

## Description
One row in this table represents a single association between a specific sale order line and a product document. It is a junction table at the grain of a unique relationship pair, serving as a raw landed copy of the link between sales order items and their corresponding product documentation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sale order line | Links to the specific line item on an order. |
| product_document_id | INTEGER | false | Foreign key to the product document | Links to the specific document entity. |

## Keys

- **Primary key (inferred):** The composite of (`sale_order_line_id`, `product_document_id`).
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `sale_order_line.id`: This column references the primary key of the sale order line table.
    - `product_document_id` → `product_document.id`: This column references the primary key of the product document repository.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure junction table; it contains no descriptive attributes, only the identifiers for the relationship.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- Ensure that joins to the target tables handle potential orphans if referential integrity is not strictly enforced at the database level in the source system.