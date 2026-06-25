# mrp_workcenter_capacity

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mrp_workcenter_capacity` (Manufacturing Resource Planning module) and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the manufacturing production planning process by defining the capacity constraints of specific work centers for given products. It is used to calculate throughput, scheduling, and resource availability within the production pipeline.

## Description
One row in this table represents a specific capacity configuration or constraint for a product assigned to a manufacturing work center. It serves as a raw landed copy of the Odoo `mrp.workcenter.capacity` model, capturing the operational parameters (capacity, start time, and stop time) required for production scheduling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mrp_workcenter_capacity_id_seq`. |
| workcenter_id | INTEGER | false | Foreign key to the work center | Links to the manufacturing work center definition. |
| product_id | INTEGER | false | Foreign key to the product | Identifies the product associated with this capacity rule. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone typically UTC. |
| capacity | DOUBLE PRECISION | true | Capacity value | The defined capacity limit for the product/workcenter pair. |
| time_start | DOUBLE PRECISION | true | Start time offset | Likely represents hours or minutes from the start of a shift. |
| time_stop | DOUBLE PRECISION | true | Stop time offset | Likely represents hours or minutes from the start of a shift. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `workcenter_id` → `mrp_workcenter.id` (Inferred from Odoo standard naming conventions).
    - `product_id` → `product_product.id` (Inferred from Odoo standard naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** No direct PII is present, though user IDs (`create_uid`, `write_uid`) link to internal employee/user records.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Units:** The `time_start` and `time_stop` columns are `DOUBLE PRECISION` and likely represent time offsets (e.g., hours); verify against the Odoo application configuration for the specific unit of measure.