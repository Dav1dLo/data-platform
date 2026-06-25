# spreadsheet_dashboard_share

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for primary keys, is highly characteristic of the Odoo framework's internal ORM structure.

## Functional process 
This table supports the "Dashboard Sharing" or "Collaboration" business process. It manages the security and access control for external or internal sharing of dashboard views, likely tracking which users created or modified the share link and providing the unique token required to access the dashboard content.

## Description
One row in this table represents a single sharing configuration or access link for a specific dashboard. It acts as a raw landing record in the staging layer, capturing the metadata and security tokens required to authenticate access to shared dashboard resources.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-incrementing values. |
| dashboard_id | INTEGER | false | Foreign key to the dashboard | Identifies the specific dashboard being shared. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who initiated the share. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the share settings. |
| access_token | VARCHAR | false | Security token | The unique string used to authorize access to the dashboard. |
| create_date | TIMESTAMP | true | Creation timestamp | When the share record was first created. |
| write_date | TIMESTAMP | true | Last update timestamp | When the share record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dashboard_id` → `dashboard.id` (Guess: links to a master dashboard definition table).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** 
    - `access_token` (This is likely the unique business identifier for the share link).

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` column acts as a credential; ensure it is masked or restricted in downstream reporting environments to prevent unauthorized access to dashboards.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are current unless a business logic layer filters them.
- **Nullability:** `create_uid` and `write_uid` may be null if the record was created via a system process or an automated migration.