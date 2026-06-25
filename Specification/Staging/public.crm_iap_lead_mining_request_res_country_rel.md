# crm_iap_lead_mining_request_res_country_rel

## Source system
The table originates from an Odoo ERP or CRM system. The naming convention `crm_iap_lead_mining_request_res_country_rel` is characteristic of Odoo's automated many-to-many relationship tables, where `_rel` denotes a join table created to link a lead mining request to specific country records.

## Functional process 
This table supports the "Lead Generation" or "IAP (In-App Purchase) Lead Mining" process. It acts as a bridge to define the geographical scope (countries) for which a specific lead mining request should be executed, allowing a single request to target multiple countries.

## Description
Each row represents a single association between a lead mining request and a target country. This is a junction table used to resolve a many-to-many relationship between lead mining requests and country entities. It serves as a raw landed copy of the relational mapping from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| "crm_iap_lead_mining_request_id" | INTEGER | false | Foreign key to the lead mining request | Links to the parent request record. |
| "res_country_id" | INTEGER | false | Foreign key to the country record | Links to the target country definition. |

## Keys

- **Primary key (inferred):** The combination of ("crm_iap_lead_mining_request_id", "res_country_id").
- **Foreign keys (inferred):**
    - "crm_iap_lead_mining_request_id" → "crm_iap_lead_mining_request"."id" (Inferred from Odoo naming convention).
    - "res_country_id" → "res_country"."id" (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table contains no descriptive data, only integer identifiers; joins to the parent `crm_iap_lead_mining_request` and `res_country` tables are required for meaningful analysis.
- As a standard Odoo `_rel` table, it does not contain audit timestamps (e.g., `created_at` or `updated_at`).
- There are no sensitive PII columns in this specific junction table.