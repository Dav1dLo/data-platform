# crm_lead_crm_lead2opportunity_partner_mass_rel

## Source system
This table likely originates from an Odoo or similar open-source ERP/CRM system. The naming convention `crm_lead2opportunity_partner_mass_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link lead conversion processes with partner or mass-mailing entities.

## Functional process 
This table supports the lead-to-opportunity conversion pipeline, specifically managing the many-to-many relationship between lead records and partner/mass-action entities. It facilitates the tracking of which leads are associated with specific mass-conversion or partner-related marketing activities.

## Description
One row in this table represents a single association between a lead and a partner/mass-action entity. As a staging table, it serves as a raw, landed copy of the join table from the source system, intended to maintain referential integrity between lead records and their associated partner entities during the data ingestion process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Surrogate key for the relationship entity | Likely a foreign key to a partner or mass-action definition table. |
| crm_lead_id | INTEGER | false | Foreign key to the lead record | References the primary lead entity. |

## Keys

- **Primary key (inferred):** `crm_lead2opportunity_partner_mass_id`, `crm_lead_id` (Composite key).
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id`: This column identifies the specific lead record involved in the relationship.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; expect high cardinality and frequent updates if the source system performs bulk lead processing.
- No audit timestamps (e.g., `created_at` or `updated_at`) are present in this schema, making it difficult to determine the recency of these relationships without joining to parent tables.
- The table structure implies a many-to-many relationship; ensure joins are handled correctly to avoid fan-out issues in downstream reporting.