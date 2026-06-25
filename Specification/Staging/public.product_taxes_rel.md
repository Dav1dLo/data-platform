# product_taxes_rel

## Source system
Unknown — insufficient evidence. The naming convention `product_taxes_rel` suggests a junction or associative table, but there are no specific prefixes or suffixes to link this to a known ERP or CRM system.

## Functional process 
This table supports the tax configuration process by mapping products to their applicable tax rates or jurisdictions. It acts as a many-to-many bridge between a product catalog and a tax definition master list, ensuring that the correct tax logic is applied during the order-to-cash or billing cycle.

## Description
One row in this table represents a single association between a product and a specific tax rule. It is a raw landed copy of a junction table, serving as the primary mechanism for resolving tax applicability for individual items in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| prod_id | INTEGER | false | Unique identifier for the product | Foreign key to the products table. |
| tax_id | INTEGER | false | Unique identifier for the tax rule | Foreign key to the taxes table. |

## Keys

- **Primary key (inferred):** The composite of `(prod_id, tax_id)`.
- **Foreign keys (inferred):** 
    - `prod_id` → `products.id` (Inferred based on the `_id` suffix and standard relational modeling).
    - `tax_id` → `taxes.id` (Inferred based on the `_id` suffix and standard relational modeling).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect duplicate `prod_id` values if a single product is subject to multiple taxes (e.g., state and local).
- There are no audit timestamps or soft-delete flags present; this table represents the current state of associations as captured during the last ingestion.
- Ensure that joins to this table are performed on both columns to maintain referential integrity and avoid Cartesian products.