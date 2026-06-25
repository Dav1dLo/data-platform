# resource_calendar_leaves

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework, alongside the sequence-based primary key pattern.

## Functional process 
This table supports the Human Resources and Scheduling modules, specifically managing time-off, leave requests, or calendar exceptions for resources. It tracks periods where a resource is unavailable or assigned to a specific non-standard activity, linking these periods to specific calendars and companies.

## Description
One row in this table represents a single leave or calendar exception period for a specific resource. It acts as a raw landed copy of the Odoo `resource.calendar.leaves` model, capturing the start and end timestamps of the leave and the associated metadata for audit and tracking purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `resource_calendar_leaves_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization owning this record. |
| calendar_id | INTEGER | true | Foreign key to the calendar | Links the leave to a specific resource calendar. |
| resource_id | INTEGER | true | Foreign key to the resource | Identifies the employee or equipment on leave. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | true | Description of the leave | Usually contains the reason or label for the leave. |
| time_type | VARCHAR | true | Type of time entry | Categorizes the leave (e.g., 'leave', 'other'). |
| date_from | TIMESTAMP | false | Start of the leave period | Inclusive start timestamp. |
| date_to | TIMESTAMP | false | End of the leave period | Inclusive end timestamp. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp for record creation. |
| write_date | TIMESTAMP | true | Last modification timestamp | Audit timestamp for last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `calendar_id` → `resource_calendar.id` (Links to the parent calendar definition).
    - `resource_id` → `resource_resource.id` (Links to the specific resource entity).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`date_from`, `date_to`, `create_date`, `write_date`) are typically stored in UTC in Odoo, but verify against the application server configuration.
- The table does not explicitly show a soft-delete flag (e.g., `active`), so assume all records are currently active unless filtered by business logic.
- `create_uid` and `write_uid` refer to the `res_users` table in the source system.
- This is a staging table; expect raw data that may require deduplication or validation of the `date_from` vs `date_to` logic before use in analytical models.