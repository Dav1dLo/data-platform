# sale_advance_payment_inv_sale_order_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific prefix `sale_advance_payment_inv` strongly indicates a many-to-many join table used by the Odoo ORM to manage the relationship between advance payment invoices and their corresponding sales orders.

## Functional process 
This table supports the Order-to-Cash process, specifically tracking the linkage between customer advance payments (prepayments) and the sales orders they are intended to settle or offset. It ensures that financial records in the invoicing module are correctly mapped to the originating commercial sales documents.

## Description
One row in this table represents a single association between an advance payment invoice record and a sales order record. As a staging table, it serves as a raw, normalized link entity representing a many-to-many relationship, allowing the system to associate multiple invoices with multiple sales orders if necessary.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_advance_payment_inv_id | INTEGER | false | Foreign key to the advance payment invoice record | Links to the primary key of the invoice entity. |
| sale_order_id | INTEGER | false | Foreign key to the sales order record | Links to the primary key of the sales order entity. |

## Keys

- **Primary key (inferred):** The composite of (`sale_advance_payment_inv_id`, `sale_order_id`).
- **Foreign keys (inferred):** 
    - `sale_advance_payment_inv_id` → `sale_advance_payment_inv.id` (Inferred from Odoo naming conventions).
    - `sale_order_id` → `sale_order.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it reflects the current state of the relationship as captured during the last ingestion.
- Ensure that joins to the target tables handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.