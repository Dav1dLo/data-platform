# crm_lead2opportunity_partner_mass

## Source system
The table likely originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence pattern (`nextval('"public".crm_lead2opportunity_partner_mass_id_seq'::regclass)`) are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically handling mass assignment or partner-related lead processing. It tracks the association between leads, partners (likely resellers or distributors), and internal users or teams, facilitating the automated or bulk distribution of leads within the sales pipeline.

## Description
One row in this table represents a single mass-action event or configuration record for assigning leads to partners or internal teams. It serves as a raw staging entity capturing the parameters of a lead-to-opportunity conversion batch, including flags for deduplication and forced assignment.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| lead_id | INTEGER | true | Foreign key to the lead | Identifier for the lead being processed. |
| partner_id | INTEGER | true | Foreign key to the partner | The partner assigned to the lead. |
| user_id | INTEGER | true | Foreign key to the user | The internal user responsible for the record. |
| team_id | INTEGER | true | Foreign key to the sales team | The sales team associated with the assignment. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| name | VARCHAR | true | Action name or description | Descriptive label for the mass action. |
| action | VARCHAR | true | Action type | Defines the specific operation performed on the lead. |
| force_assignment | BOOLEAN | true | Force assignment flag | If true, overrides existing assignments. |
| deduplicate | BOOLEAN | true | Deduplication flag | If true, triggers deduplication logic. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Guess: standard Odoo lead table)
    - `partner_id` → `res_partner.id` (Guess: standard Odoo partner table)
    - `user_id` → `res_users.id` (Guess: standard Odoo users table)
    - `team_id` → `crm_team.id` (Guess: standard Odoo sales team table)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely permanent unless purged.
- **Data Integrity:** As a staging table, `lead_id`, `partner_id`, and `user_id` may contain orphaned references if the source system has undergone cleanup or if the records were deleted in the source.
- **Sensitivity:** Contains user IDs and potentially sensitive lead assignment logic; ensure access is restricted to authorized personnel.