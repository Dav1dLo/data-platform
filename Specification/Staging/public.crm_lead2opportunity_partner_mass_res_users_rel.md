# crm_lead2opportunity_partner_mass_res_users_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `crm_lead2opportunity_partner_mass_res_users_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link a specific wizard or mass-action process (`crm_lead2opportunity_partner_mass`) to system users (`res_users`).

## Functional process 
This table supports the "Lead-to-Opportunity" conversion process within the CRM module. It tracks the association between mass-action lead conversion events and the specific system users involved in or assigned to those conversion tasks.

## Description
One row in this table represents a single link between a lead-to-opportunity mass conversion event and a user record. It serves as a raw junction table in the staging layer, facilitating the resolution of many-to-many relationships between CRM conversion processes and system users.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Foreign key to the mass conversion event | Links to the parent process table. |
| res_users_id | INTEGER | false | Foreign key to the system user | Identifies the user involved in the conversion. |

## Keys

- **Primary key (inferred):** The combination of `crm_lead2opportunity_partner_mass_id` and `res_users_id`.
- **Foreign keys (inferred):** 
    - `crm_lead2opportunity_partner_mass_id` → `crm_lead2opportunity_partner_mass.id`: This column references the primary key of the mass conversion process table.
    - `res_users_id` → `res_users.id`: This column references the primary key of the system users table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure joins are performed on both columns to maintain referential integrity, as neither column is unique on its own.