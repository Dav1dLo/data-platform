# account_fiscal_position_res_country_state_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `account_fiscal_position` and `res_country_state` is characteristic of Odoo's automated many-to-many relationship tables used to link fiscal positions (tax mapping rules) to specific geographic states.

## Functional process 
This table supports the tax configuration and localization process. It defines the scope of fiscal positions by mapping them to specific states or provinces, ensuring that tax rules are applied correctly based on the customer's or company's geographic location within a country.

## Description
One row represents a single association between a fiscal position and a geographic state, indicating that the fiscal position is applicable to that specific state. This is a raw landing of a join table used to resolve many-to-many relationships in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_fiscal_position_id | INTEGER | false | Foreign key to the fiscal position definition. | Links to the primary tax mapping entity. |
| res_country_state_id | INTEGER | false | Foreign key to the geographic state/province. | Identifies the specific region affected by the fiscal position. |

## Keys

- **Primary key (inferred):** The combination of `account_fiscal_position_id` and `res_country_state_id`.
- **Foreign keys (inferred):** 
    - `account_fiscal_position_id` → `account_fiscal_position.id`: This column references the master table for fiscal tax mappings.
    - `res_country_state_id` → `res_country_state.id`: This column references the master table for geographic states.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of relationships as defined in the source system.
- Ensure inner joins are used when querying to avoid orphaned records if the source system has referential integrity gaps.