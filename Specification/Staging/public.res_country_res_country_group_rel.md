# res_country_res_country_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_country_res_country_group_rel` is a standard pattern used by Odoo's ORM to manage many-to-many relationship tables between the `res.country` and `res.country.group` models.

## Functional process 
This table supports the grouping of countries for functional purposes such as regional pricing, tax application, or shipping zone management. It acts as a bridge to associate multiple countries with specific country groups defined within the ERP.

## Description
One row in this table represents a single association between a country and a country group. It is a raw landing copy of the join table used to resolve many-to-many relationships in the source system. The grain is one row per country-to-group mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_country_id | INTEGER | false | Foreign key to the country definition | Maps to the primary key of the country table. |
| res_country_group_id | INTEGER | false | Foreign key to the country group definition | Maps to the primary key of the country group table. |

## Keys

- **Primary key (inferred):** The composite key (`res_country_id`, `res_country_group_id`).
- **Foreign keys (inferred):** 
    - `res_country_id` → `res_country.id`: This column references the unique identifier of a country.
    - `res_country_group_id` → `res_country_group.id`: This column references the unique identifier of a country group.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; this table reflects the current state of associations as captured during the last ingestion.
- Ensure joins to parent tables are performed using an `INNER JOIN` if you only require records with valid, existing country and group definitions.