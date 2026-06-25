# crm_lead_scoring_frequency

## Source system
This table originates from an Odoo ERP or CRM system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for the primary key, are characteristic signatures of the Odoo framework's ORM layer.

## Functional process 
This table supports the lead-to-cash pipeline by tracking historical performance metrics for lead scoring variables. It aggregates the success (`won_count`) and failure (`lost_count`) rates associated with specific lead attributes (`variable` and `value`), allowing the system to calculate the probability of conversion for incoming leads.

## Description
One row in this table represents a specific frequency count of a lead attribute (e.g., a specific industry or source) and its associated win/loss outcome history. As a staging table, it provides a raw, landed copy of the scoring frequency data directly from the source CRM, intended for use in downstream analytical models that calculate lead conversion propensity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by PostgreSQL sequence. |
| team_id | INTEGER | true | Foreign key to the CRM sales team | Links the scoring data to a specific sales department. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user table. |
| variable | VARCHAR | true | The lead attribute being measured | e.g., 'country', 'source', or 'industry'. |
| value | VARCHAR | true | The specific value of the variable | e.g., 'USA', 'Email', or 'Tech'. |
| won_count | NUMERIC | true | Number of leads won with this attribute | Used for calculating conversion rates. |
| lost_count | NUMERIC | true | Number of leads lost with this attribute | Used for calculating conversion rates. |
| create_date | TIMESTAMP | true | Record creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: standard Odoo naming convention for sales teams).
    - `create_uid` → `res_users.id` (Guess: standard Odoo naming convention for system users).
    - `write_uid` → `res_users.id` (Guess: standard Odoo naming convention for system users).
- **Natural keys (inferred):** Not confidently inferable. While `variable` and `value` are business-relevant, they may not be unique across different `team_id` contexts.

## Caveats for downstream consumers

- **Sensitive Data:** Contains internal user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Data Integrity:** `won_count` and `lost_count` are `NUMERIC` types; ensure proper casting if performing arithmetic in downstream SQL.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag, suggesting it may only contain active records or that deletions are hard-deleted at the source.