# crm_lead2opportunity_partner

## Source system
This table likely originates from an Odoo ERP or CRM system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence pattern `nextval('"public".crm_lead2opportunity_partner_id_seq'::regclass)` are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the lead-to-opportunity conversion process, specifically tracking the assignment of leads to partners or internal sales teams. It acts as a bridge to manage lead distribution logic, capturing who (user/team) or which entity (partner) is responsible for a lead during the transition phase.

## Description
Each row represents a specific assignment or action record linking a lead to a partner or internal sales resource. As a staging table, it provides a raw, landed copy of the assignment history, serving as the foundation for downstream models that track lead conversion performance and partner attribution.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a database sequence. |
| lead_id | INTEGER | false | Foreign key to the lead | The identifier for the lead being processed. |
| partner_id | INTEGER | true | Foreign key to the partner | The partner entity assigned to the lead. |
| user_id | INTEGER | true | Foreign key to the user | The internal sales representative assigned. |
| team_id | INTEGER | true | Foreign key to the sales team | The sales team responsible for the lead. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| name | VARCHAR | true | Action name or description | Descriptive label for the assignment action. |
| action | VARCHAR | true | Action type | Categorization of the lead assignment action. |
| force_assignment | BOOLEAN | true | Manual override flag | Indicates if the assignment was forced manually. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in server time (usually UTC). |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Inferred from standard Odoo naming conventions for lead-related tables).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo naming conventions for partner entities).
    - `user_id` → `res_users.id` (Inferred from standard Odoo naming conventions for system users).
    - `team_id` → `crm_team.id` (Inferred from standard Odoo naming conventions for sales teams).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and potentially identifiable partner/lead associations; ensure access is restricted according to internal PII policies.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume it contains the full history of records as landed from the source.
- **Data Integrity:** As a staging table, expect potential duplicates or multiple entries per `lead_id` if the assignment logic allows for reassignment history.