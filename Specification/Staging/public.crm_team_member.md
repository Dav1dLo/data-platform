# crm_team_member

## Source system
The table likely originates from an Odoo ERP or CRM system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence for the primary key (`nextval('"public".crm_team_member_id_seq'::regclass)`), is highly characteristic of the Odoo framework's internal database schema.

## Functional process 
This table supports the "Sales Team Management" process, specifically defining the membership and workload configuration for users within a CRM team. It manages how individual team members are assigned tasks or leads, including workload limits (`assignment_max`) and opt-out preferences, which are critical for automated lead distribution workflows.

## Description
One row in this table represents a single association between a user and a CRM team, defining their specific role and assignment parameters within that team. As a staging table, it serves as a raw, direct copy of the source system's membership configuration, intended for use in downstream transformations to build team-based reporting or assignment logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-increment. |
| crm_team_id | INTEGER | false | Foreign key to the CRM team | Links to the parent team entity. |
| user_id | INTEGER | false | Foreign key to the system user | Identifies the team member. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for record creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail for record modification. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the membership is currently enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the source system. |
| assignment_max | INTEGER | true | Maximum lead assignment limit | Defines the workload capacity for the member. |
| assignment_domain | VARCHAR | true | Assignment filter criteria | A domain string used to filter leads for this member. |
| assignment_optout | BOOLEAN | true | Lead assignment opt-out status | If true, the member is excluded from automated assignments. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `crm_team_id` → `crm_team.id` (Inferred from standard Odoo naming conventions for team associations).
    - `user_id` → `res_users.id` (Inferred from standard Odoo naming conventions for user links).
- **Natural keys (inferred):** 
    - The combination of `crm_team_id` and `user_id` likely acts as the business-level unique identifier for a membership record.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` and audit user IDs (`create_uid`, `write_uid`), which may need to be joined with user metadata tables to identify individuals.
- **Timestamps:** Timestamps are assumed to be in the source system's timezone (typically UTC in Odoo).
- **Soft Deletes:** The `active` column should be checked; rows where `active = false` are logically deleted and should generally be excluded from active reporting.
- **Assignment Logic:** The `assignment_domain` column contains a serialized domain string (likely JSON or Odoo-specific syntax) that requires parsing if used for complex filtering logic.