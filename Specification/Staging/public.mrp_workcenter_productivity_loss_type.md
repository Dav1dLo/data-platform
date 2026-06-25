# mrp_workcenter_productivity_loss_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_workcenter_productivity_loss_type`), the use of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific sequence-based default value pattern for the `id` column.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the categorization of productivity losses at work centers. It defines the taxonomy of reasons (e.g., machine breakdown, material shortage, operator absence) used to classify downtime or efficiency loss during production runs.

## Description
One row in this table represents a single category or type of productivity loss defined within the manufacturing module. This is a raw landing table in the staging layer, containing a direct copy of the configuration data used to classify work center performance issues.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a standard Odoo sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| loss_type | VARCHAR | false | The name or code of the loss category | The business-facing label for the loss. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field referencing the user table).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field referencing the user table).
- **Natural keys (inferred):** 
    - `loss_type` (Assuming this is a unique label for the loss category).

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo identifiers; they will not resolve to meaningful names without joining to the `res_users` table.
- **Data Integrity:** As a staging table, this may contain historical or deprecated loss types; ensure queries filter for active records if the source system supports soft-deletion or status flags (though none are explicitly present here).