# crm_lead_crm_lead2opportunity_partner_rel

## Source system
The table likely originates from a CRM system such as Odoo or a similar modular ERP, given the naming convention `crm_lead2opportunity_partner_rel` which is characteristic of many-to-many relationship tables in Python-based ORMs (like Odoo's PostgreSQL backend) used to link leads to partner/opportunity entities.

## Functional process 
This table supports the lead-to-opportunity conversion process by maintaining the relational mapping between lead records and their associated partner or opportunity entities. It facilitates the tracking of how leads are transitioned or linked to specific business partners during the sales pipeline.

## Description
One row in this table represents a single association between a lead and a partner/opportunity record. It serves as a raw landing join table in the staging layer, intended to resolve many-to-many relationships between the lead and partner entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_id | INTEGER | false | Surrogate primary key for the relationship record | Unique identifier for this specific link. |
| crm_lead_id | INTEGER | false | Foreign key referencing the lead entity | Identifies the lead involved in the relationship. |

## Keys

- **Primary key (inferred):** `crm_lead2opportunity_partner_id`
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id`: This column links to the primary lead record in the CRM system.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; ensure inner joins are used if you only require records with valid lead associations.
- No timestamps are present, so audit tracking of when these relationships were created is not possible from this table alone.
- The table structure suggests a standard ORM-generated link table; verify if additional columns exist in the source system that were excluded from this landing set.