# account_tax_sale_order_line_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular accounting/ERP system. The naming convention `_rel` is characteristic of join tables used in Odoo's ORM to manage many-to-many relationships between sales order lines and tax definitions.

## Functional process 
This table supports the tax calculation and financial reporting process within the order-to-cash pipeline. It maps specific tax rules or rates to individual line items on a sales order, ensuring that the correct tax amounts are applied during invoicing and accounting reconciliation.

## Description
One row in this table represents a single association between a sales order line item and a specific tax record. It acts as a bridge table to resolve a many-to-many relationship, allowing a single line item to be subject to multiple taxes (e.g., VAT and local excise tax) or a single tax to be applied to multiple line items. This is a raw landing copy of the relationship entity in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sales order line | Links to the specific item being sold. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Links to the tax configuration record. |

## Keys

- **Primary key (inferred):** The combination of `(sale_order_line_id, account_tax_id)`.
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `sale_order_line.id` (Inferred from naming convention).
    - `account_tax_id` → `account_tax.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes other than the two foreign keys.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of relationships as extracted from the source.
- Ensure inner joins are used when filtering by specific tax types to avoid orphaned records if the source system has referential integrity gaps.