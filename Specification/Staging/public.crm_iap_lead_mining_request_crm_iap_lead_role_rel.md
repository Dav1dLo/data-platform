# crm_iap_lead_mining_request_crm_iap_lead_role_rel

## Source system
The table likely originates from an internal CRM or Lead Management system, given the naming convention `crm_iap_lead_mining_request`. The structure suggests a relational database backend where this table serves as a join table for a many-to-many relationship between lead mining requests and lead roles.

## Functional process 
This table supports the lead qualification and assignment process. It maps specific lead mining requests to the roles associated with those leads, ensuring that the correct functional roles are linked to the appropriate mining request workflow.

## Description
One row in this table represents a single association between a lead mining request and a lead role. It acts as a link table in the staging layer, maintaining the referential integrity of the many-to-many relationship between mining requests and their assigned roles.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request entity. | Part of the composite primary key. |
| crm_iap_lead_role_id | INTEGER | false | Foreign key to the lead role entity. | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `crm_iap_lead_mining_request_id`, `crm_iap_lead_role_id` (composite).
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id` (inferred from column name).
    - `crm_iap_lead_role_id` → `crm_iap_lead_role.id` (inferred from column name).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- Ensure that joins to parent tables handle potential orphans if the staging load process is not perfectly synchronized.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of relationships as captured during the last ingestion.