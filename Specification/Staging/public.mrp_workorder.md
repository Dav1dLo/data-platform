# mrp_workorder

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention `mrp_workorder`, the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific pattern of linking work orders to production IDs and work centers.

## Functional process 
This table supports the Manufacturing (MRP) execution process, specifically tracking the progress of individual operations within a manufacturing order. It captures the scheduling, duration, and completion status of tasks performed at specific work centers, facilitating shop floor control and production reporting.

## Description
One row represents a single work order operation within a manufacturing production process. It tracks the status, timing, and quantity produced for a specific step in the production workflow. This table serves as a raw landed copy of the Odoo `mrp.workorder` model within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mrp_workorder_id_seq`. |
| sequence | INTEGER | true | Execution order sequence | Determines the order of operations. |
| workcenter_id | INTEGER | false | Foreign key to work center | The location where the work is performed. |
| product_id | INTEGER | true | Foreign key to product | The item being processed. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | The UoM for the produced quantity. |
| production_id | INTEGER | true | Foreign key to manufacturing order | Links to the parent production record. |
| leave_id | INTEGER | true | Foreign key to resource leave | Links to scheduling/calendar leave. |
| duration_percent | INTEGER | true | Progress percentage | Expected vs actual duration ratio. |
| operation_id | INTEGER | true | Foreign key to routing operation | The specific operation template used. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last updater user ID | Audit field for record modification. |
| name | VARCHAR | false | Work order name | Descriptive label for the operation. |
| barcode | VARCHAR | true | Barcode identifier | Used for scanning on the shop floor. |
| production_availability | VARCHAR | true | Material availability status | Indicates if components are ready. |
| state | VARCHAR | true | Work order status | e.g., 'pending', 'ready', 'progress', 'done'. |
| qty_produced | NUMERIC | true | Quantity produced | Total quantity completed for this step. |
| duration_expected | NUMERIC | true | Expected duration | Estimated time to complete in minutes. |
| qty_reported_from_previous_wo | NUMERIC | true | Previous step quantity | Quantity passed from the prior operation. |
| date_start | TIMESTAMP | true | Start timestamp | Actual start time of the work order. |
| date_finished | TIMESTAMP | true | Finish timestamp | Actual completion time of the work order. |
| production_date | TIMESTAMP | true | Scheduled production date | Planned date for this operation. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time. |
| duration | DOUBLE PRECISION | true | Actual duration | Total time spent in minutes. |
| duration_unit | DOUBLE PRECISION | true | Unit duration | Time spent per unit. |
| costs_hour | DOUBLE PRECISION | true | Hourly cost rate | Cost rate applied to the work center. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `workcenter_id` → `mrp_workcenter.id` (Standard Odoo naming convention)
    - `product_id` → `product_product.id` (Standard Odoo naming convention)
    - `production_id` → `mrp_production.id` (Links to parent manufacturing order)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD behavior.
- **Data Quality:** `qty_produced` and `duration` fields may be null for work orders that have not yet started or are in a 'pending' state.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal Odoo user IDs and do not contain human-readable names.