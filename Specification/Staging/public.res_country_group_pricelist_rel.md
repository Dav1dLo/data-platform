# res_country_group_pricelist_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `res_country_group_pricelist_rel` follows the standard Odoo pattern for a many-to-many join table linking country groups to specific pricing lists.

## Functional process 
This table supports the pricing and localization business process by mapping specific country groups to applicable pricelists. It ensures that when a customer is identified as belonging to a specific country group, the system can resolve the correct pricing strategy defined in the `pricelist` entity.

## Description
One row in this table represents a single association between a country group and a pricelist. It serves as a raw landing join table in the staging layer, facilitating the resolution of many-to-many relationships between geographic pricing segments and product price definitions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pricelist_id | INTEGER | false | Foreign key to the pricelist definition | Maps to the primary key of the pricelist table. |
| res_country_group_id | INTEGER | false | Foreign key to the country group definition | Maps to the primary key of the res_country_group table. |

## Keys

- **Primary key (inferred):** The composite of (`pricelist_id`, `res_country_group_id`).
- **Foreign keys (inferred):** 
    - `pricelist_id` → `pricelist.id`: Links to the master pricelist record.
    - `res_country_group_id` → `res_country_group.id`: Links to the master country group record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- As a staging table, it may contain orphaned records if referential integrity is not strictly enforced at the source system level.
- There are no timestamps or audit columns present to track when these associations were created or modified.