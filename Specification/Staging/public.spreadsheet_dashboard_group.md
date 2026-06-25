# spreadsheet_dashboard_group

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a PostgreSQL sequence for the primary key.

## Functional process 
This table supports the organization and grouping of dashboard elements within a spreadsheet-based reporting module. It manages the structural hierarchy or display order of dashboard components, likely used by the UI to render grouped views for end-users.

## Description
One row in this table represents a single dashboard group entity used to categorize or sequence dashboard widgets. As a staging table, it serves as a raw, direct reflection of the underlying Odoo database record, capturing the metadata and display configuration for dashboard groupings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `spreadsheet_dashboard_group_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to determine the UI sort order of groups. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system's user table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system's user table. |
| name | JSONB | false | Group display name | Stored as JSONB, likely containing multi-language strings. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `name` column is a `JSONB` object; queries will need to use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract specific string values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- This table contains no explicit soft-delete flag; assume all records are active unless otherwise specified by business logic.
- The `sequence` column may contain nulls, which should be handled as either the beginning or end of the sort order depending on the application's implementation.