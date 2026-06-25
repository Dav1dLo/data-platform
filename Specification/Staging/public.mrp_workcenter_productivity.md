# mrp_workcenter_productivity

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`mrp_workcenter_productivity`), the use of `create_uid`/`write_uid` audit columns, and the sequence-based `id` primary key pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the Manufacturing (MRP) module's productivity tracking, specifically capturing downtime or efficiency losses at the workcenter level. It records the duration and nature of productivity events, linking them to specific work orders, users, and loss categories to facilitate OEE (Overall Equipment Effectiveness) analysis.

## Description
One row represents a single productivity or loss event occurring at a manufacturing workcenter, tracking the time interval between `date_start` and `date_end`. As a staging table, it serves as a raw, direct copy of the Odoo operational data, intended for downstream transformation into analytical fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| workcenter_id | INTEGER | false | Foreign key to the workcenter | Identifies the machine or station. |
| company_id | INTEGER | false | Foreign key to the company | Multi-tenant identifier. |
| workorder_id | INTEGER | true | Foreign key to the work order | Links to the specific production task. |
| user_id | INTEGER | true | Foreign key to the user | The operator associated with the event. |
| loss_id | INTEGER | false | Foreign key to the loss category | Defines the reason for the productivity event. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| loss_type | VARCHAR | true | Classification of the loss | e.g., 'productive', 'availability', 'performance'. |
| description | TEXT | true | Descriptive notes | Free-text explanation of the event. |
| date_start | TIMESTAMP | false | Start of the event | Timestamp in UTC. |
| date_end | TIMESTAMP | true | End of the event | Timestamp in UTC. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp. |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit timestamp. |
| duration | DOUBLE PRECISION | true | Event duration | Likely in minutes or hours. |
| account_move_line_id | INTEGER | true | Foreign key to accounting | Links productivity to financial entries. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Guessed: standard Odoo relation)
    - `workorder_id` → `mrp_workorder.id` (Guessed: standard Odoo relation)
    - `user_id` → `res_users.id` (Guessed: standard Odoo relation)
    - `loss_id` → `mrp_workcenter_productivity_loss.id` (Guessed: standard Odoo relation)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless filtered by business logic.
- **Duration:** The unit of `duration` is not explicitly defined in the schema; verify against source system configuration (typically minutes).
- **Audit Columns:** `create_uid` and `write_uid` refer to the `res_users` table; these IDs are not globally unique across different Odoo instances.