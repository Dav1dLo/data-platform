# crm_convert_lead_mass_lead_rel

## Source system
The table likely originates from a CRM system (e.g., Salesforce, HubSpot, or a custom-built lead management platform). The naming convention `crm_lead2opportunity_partner_mass_id` suggests a relational mapping table used to track bulk lead conversion processes or partner-led lead distribution.

## Functional process 
This table supports the lead-to-opportunity conversion pipeline, specifically managing the relationship between bulk lead processing events and individual lead records. It acts as a join table to associate specific leads with a mass-conversion or partner-distribution batch.

## Description
One row in this table represents a single association between a lead and a mass-conversion or partner-distribution event. It serves as a raw landing copy of the relational link, enabling the tracking of which leads were processed within specific bulk operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Surrogate key for the mass conversion or partner event. | Likely a foreign key to a parent batch or event table. |
| crm_lead_id | INTEGER | false | Unique identifier for the lead record. | Likely a foreign key to the primary leads table. |

## Keys

- **Primary key (inferred):** The combination of `crm_lead2opportunity_partner_mass_id` and `crm_lead_id` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `crm_lead2opportunity_partner_mass_id` → `crm_lead2opportunity_partner_mass.id` (guess: links to the parent batch event).
    - `crm_lead_id` → `crm_leads.id` (guess: links to the master lead record).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a mapping table; expect high cardinality and frequent joins to parent entities.
- There are no timestamps or audit columns present; it is impossible to determine the sequence of events or the ingestion time from this table alone.
- The table contains only identifiers; it does not contain PII or business logic, so no masking is required.