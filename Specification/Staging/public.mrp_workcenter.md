# mrp_workcenter

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_workcenter`, the use of `create_uid`/`write_uid` audit fields, and the `analytic_distribution` JSONB column, which are characteristic patterns of the Odoo framework's Manufacturing (MRP) module.

## Functional process 
This table supports the production planning and manufacturing execution process. It defines the physical or logical work centers where manufacturing operations occur, tracking their capacity, efficiency, hourly costs, and operational status to facilitate scheduling and cost accounting.

## Description
One row represents a single work center within the manufacturing facility, defining its operational parameters and resource constraints. As a staging table, it serves as a raw, landed copy of the Odoo `mrp.workcenter` model, intended for ingestion into downstream analytical models for capacity planning and production cost analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| resource_id | INTEGER | false | Link to resource master | Foreign key to the base resource table. |
| company_id | INTEGER | true | Owning company ID | Multi-company context identifier. |
| resource_calendar_id | INTEGER | true | Working time calendar | Defines the shifts and availability. |
| sequence | INTEGER | false | Display order | Used for sorting in UI/reports. |
| color | INTEGER | true | UI color index | Used for visual categorization. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | true | Work center name | Descriptive label of the work center. |
| code | VARCHAR | true | Internal code | Short alphanumeric identifier. |
| working_state | VARCHAR | true | Operational status | e.g., 'normal', 'blocked', 'under_maintenance'. |
| note | TEXT | true | Description | Free-text notes regarding the work center. |
| active | BOOLEAN | true | Soft-delete flag | If false, the record is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| time_efficiency | DOUBLE PRECISION | true | Efficiency factor | Multiplier for production time calculations. |
| default_capacity | DOUBLE PRECISION | true | Capacity units | Number of items processed simultaneously. |
| costs_hour | DOUBLE PRECISION | true | Hourly cost rate | Cost per hour for accounting purposes. |
| time_start | DOUBLE PRECISION | true | Setup time | Time required to start the operation. |
| time_stop | DOUBLE PRECISION | true | Cleanup time | Time required to finish the operation. |
| oee_target | DOUBLE PRECISION | true | OEE target percentage | Overall Equipment Effectiveness goal. |
| expense_account_id | INTEGER | true | Accounting account | Linked GL account for expenses. |
| analytic_distribution | JSONB | true | Analytic accounting | JSON blob for cost center allocations. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `resource_id` → `resource.id` (Guess: Standard Odoo resource link)
    - `company_id` → `res_company.id` (Guess: Standard Odoo multi-company link)
    - `resource_calendar_id` → `resource_calendar.id` (Guess: Standard Odoo calendar link)
    - `expense_account_id` → `account_account.id` (Guess: Standard Odoo accounting link)
- **Natural keys (inferred):** 
    - `code` (Assuming unique internal business identifier)

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column indicates soft-deleted records; ensure your queries filter by `WHERE active = TRUE` unless you intend to include archived work centers.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **JSONB:** The `analytic_distribution` column contains complex nested data; use PostgreSQL JSONB operators (e.g., `->>`) to extract specific keys for reporting.
- **Sensitivity:** No direct PII is present, but `costs_hour` and `analytic_distribution` may be considered sensitive financial data.