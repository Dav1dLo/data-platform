# crm_lead_crm_lead_lost_rel

## Source system
The table likely originates from a CRM system such as Odoo or a similar relational database-backed customer management platform. The naming convention `_rel` and the structure of linking two IDs suggest this is a join table representing a many-to-many or one-to-many relationship between leads and lost-lead reasons or metadata.

## Functional process 
This table supports the sales pipeline management process, specifically tracking the relationship between lead records and the reasons or metadata associated with a "lost" status. It facilitates reporting on lead conversion rates and churn analysis by linking specific lead entities to their loss-related attributes.

## Description
One row in this table represents a single association between a lead and a lost-lead record. It serves as a raw landing copy of a relational mapping table, maintaining the link between the primary lead entity and its corresponding loss classification at the grain of one row per relationship instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead_lost_id | INTEGER | false | Surrogate key for the lost-lead reason or record | Foreign key to a lookup or metadata table. |
| crm_lead_id | INTEGER | false | Surrogate key for the lead record | Foreign key to the main CRM lead table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`crm_lead_lost_id`, `crm_lead_id`).
- **Foreign keys (inferred):** 
    - `crm_lead_lost_id` → `crm_lead_lost.id` (Guess: links to a table defining loss reasons).
    - `crm_lead_id` → `crm_lead.id` (Guess: links to the primary lead record).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a join table; ensure joins to parent tables are handled correctly to avoid fan-outs if the relationship is not strictly 1:1.
- No audit timestamps or soft-delete flags are present; assume this represents the current state of relationships as captured during the last ingestion.
- The table contains no PII, but represents sensitive business process data regarding lost sales opportunities.