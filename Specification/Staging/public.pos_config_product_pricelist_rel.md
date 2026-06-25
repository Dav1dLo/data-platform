# pos_config_product_pricelist_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `pos_config_product_pricelist_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link Point of Sale (POS) configurations to available product pricelists.

## Functional process 
This table supports the Point of Sale (POS) configuration process by defining the mapping between specific POS terminals or shop settings and the pricelists they are authorized to use. It ensures that when a cashier operates a specific POS configuration, the system knows which pricing rules to apply to products.

## Description
One row in this table represents a single association between a POS configuration and a product pricelist. It serves as a raw landing copy of a join table, facilitating the many-to-many relationship required to allow multiple pricelists to be assigned to a single POS configuration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Represents the specific POS terminal or shop instance. |
| product_pricelist_id | INTEGER | false | Foreign key to the product pricelist | Represents the pricing strategy or list assigned to the POS. |

## Keys

- **Primary key (inferred):** The combination of `(pos_config_id, product_pricelist_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: Links to the configuration settings for a POS terminal.
    - `product_pricelist_id` → `product_pricelist.id`: Links to the definition of the pricelist.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present, so incremental loading based on `updated_at` is not possible.
- Ensure joins to the target tables handle potential orphans if referential integrity is not strictly enforced in the source system.