# crm_iap_lead_industry_crm_iap_lead_mining_request_rel

## Source system
The table appears to originate from a custom CRM or Lead Management system, likely built on a relational database. The naming convention `_rel` strongly suggests this is a join table (associative entity) used to manage a many-to-many relationship between lead mining requests and industry classifications.

## Functional process 
This table supports the lead qualification and segmentation process. It maps specific lead mining requests to the industries they are associated with, allowing the system to categorize or filter leads based on industry-specific criteria during the lead-to-cash or prospecting pipeline.

## Description
One row in this table represents a single association between a lead mining request and an industry classification. It serves as a raw landing copy of a junction table, facilitating the resolution of a many-to-many relationship between the `crm_iap_lead_mining_request` and `crm_iap_lead_industry` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request entity. | Part of the composite primary key. |
| crm_iap_lead_industry_id | INTEGER | false | Foreign key to the industry classification entity. | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(crm_iap_lead_mining_request_id, crm_iap_lead_industry_id)`
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id` (Inferred from naming convention).
    - `crm_iap_lead_industry_id` → `crm_iap_lead_industry.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against both the lead mining request and industry tables to retrieve meaningful business attributes.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of associations as captured during the last ingestion.
- The table contains no PII, as it only holds surrogate identifiers.