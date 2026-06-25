# crm_merge_opportunity

## Source system
The table likely originates from an Odoo ERP or a similar Python-based framework, evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo's ORM, and the use of `nextval` sequences for primary keys.

## Functional process 
This table supports the CRM lead-to-cash or sales pipeline management process, specifically tracking the merging of duplicate or related opportunity records. It acts as a join or audit log for consolidating sales opportunities to maintain data hygiene within the CRM.

## Description
One row in this table represents a single merge event or relationship between CRM opportunities. It serves as a raw landed staging entity, capturing the audit trail of who performed a merge and when, as well as the associated user and team context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-incrementing. |
| user_id | INTEGER | true | Identifier of the CRM user | Likely a foreign key to a users table. |
| team_id | INTEGER | true | Identifier of the sales team | Likely a foreign key to a sales_team table. |
| create_uid | INTEGER | true | User ID who created the record | Audit field for record creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit field for record modification. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo pattern for user associations).
    - `team_id` → `crm_team.id` (Guess: standard Odoo pattern for sales team associations).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Audit Fields:** `create_uid` and `write_uid` refer to internal system user IDs; ensure these are joined against the appropriate user dimension table to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL/Odoo staging practices.
- **Data Integrity:** As a staging table, this may contain transient data or intermediate states of merge operations; verify if records represent completed merges or ongoing processes.
- **Sensitivity:** No explicit PII is present, but `user_id` and `team_id` allow for the attribution of sales activities to specific employees.