# crm_iap_lead_mining_request_res_country_state_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `crm_iap_lead_mining_request_res_country_state_rel` follows the standard Odoo pattern for a many-to-many relationship table (often suffixed with `_rel`), linking a lead mining request to specific country states.

## Functional process 
This table supports the Lead-to-Cash pipeline, specifically the IAP (In-App Purchase) lead mining module. It manages the association between a specific lead generation request and the geographical scope (states/provinces) targeted by that request.

## Description
One row in this table represents a single association between a lead mining request and a specific country state. It serves as a raw junction table in the staging layer, enabling the many-to-many relationship required to filter or target leads by multiple state locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the parent request entity. |
| res_country_state_id | INTEGER | false | Foreign key to the country state definition | Identifies the specific state/province involved. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(crm_iap_lead_mining_request_id, res_country_state_id)`.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the primary request record.
    - `res_country_state_id` → `res_country_state.id`: This column references the master list of country states.
- **Natural keys (inferred):** The combination of `crm_iap_lead_mining_request_id` and `res_country_state_id` acts as the unique business identifier for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table represents the current state of relationships as ingested from the source.
- Ensure joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced.