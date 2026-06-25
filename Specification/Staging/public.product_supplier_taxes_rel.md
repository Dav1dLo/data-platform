# product_supplier_taxes_rel

## Source system
The source system is unknown — insufficient evidence. The table name suggests a relational mapping between products and tax configurations, which is common in ERP or e-commerce platforms, but the naming convention does not align with major off-the-shelf systems like SAP, Salesforce, or Stripe.

## Functional process 
This table supports the tax calculation and compliance process by mapping products to their applicable tax identifiers. It likely facilitates the lookup of tax rates or rules during the checkout or invoicing phase of a sales pipeline.

## Description
One row in this table represents a single association between a specific product and a tax category or tax rule. This is a junction table used to resolve a many-to-many relationship between products and taxes in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| prod_id | INTEGER | false | Unique identifier for the product. | Foreign key to a product master table. |
| tax_id | INTEGER | false | Unique identifier for the tax rule or category. | Foreign key to a tax configuration table. |

## Keys

- **Primary key (inferred):** The composite key `(prod_id, tax_id)` is the inferred primary key, as this is a junction table.
- **Foreign keys (inferred):** 
    - `prod_id` → `products.id` (Guess: standard naming convention for product references).
    - `tax_id` → `taxes.id` (Guess: standard naming convention for tax references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag, so it is impossible to determine the history or validity period of these mappings from this table alone.
- Ensure that joins to parent tables handle potential orphan records if referential integrity is not strictly enforced in the source system.