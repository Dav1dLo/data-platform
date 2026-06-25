# sale_order_line_invoice_rel

## Source system
The table likely originates from an ERP or e-commerce platform such as Odoo or a similar modular business system. The naming convention `_rel` is characteristic of join tables used in ORM frameworks to manage many-to-many relationships between order lines and invoice lines.

## Functional process 
This table supports the order-to-cash process by maintaining the link between specific line items on a sales order and the corresponding lines on generated invoices. It allows the system to track which portion of an order has been billed and to reconcile payments against specific order fulfillment records.

## Description
One row in this table represents a single association between a sales order line and an invoice line. It acts as a bridge table at the grain of a specific link instance, serving as a raw landed copy of the relationship mapping from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_line_id | INTEGER | false | Unique identifier for the invoice line | Foreign key to the invoice lines table. |
| order_line_id | INTEGER | false | Unique identifier for the sales order line | Foreign key to the sales order lines table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(invoice_line_id, order_line_id)`.
- **Foreign keys (inferred):** 
    - `invoice_line_id` → `invoice_line.id`: Links to the specific invoice line record.
    - `order_line_id` → `sale_order_line.id`: Links to the specific sales order line record.
- **Natural keys (inferred):** The combination of `invoice_line_id` and `order_line_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present to indicate when these relationships were created or modified.
- Ensure that joins to parent tables handle potential orphan records if the source system does not enforce strict referential integrity at the database level.