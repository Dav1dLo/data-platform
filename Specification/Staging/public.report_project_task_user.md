# report_project_task_user

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `partner_id`, `stage_id`, `sale_order_id`, and the specific pattern of tracking task-related metrics like `working_days_open` and `rating_avg` within a project management module.

## Functional process 
This table supports the Project Management and Service Delivery business processes. It aggregates task-level data, including assignment details, lifecycle stages, and performance metrics (such as duration and delay), to facilitate reporting on project progress, resource allocation, and customer satisfaction.

## Description
One row in this table represents a single task assigned to a user within a project, capturing its current state, timeline, and performance metrics. As a staging table, it serves as a raw, denormalized landing copy of project task data, intended for downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| nbr | INTEGER | true | Record count or sequence number | Likely used for aggregation in reporting views. |
| id | INTEGER | true | Internal surrogate ID | Unique identifier for the task record. |
| task_id | INTEGER | true | Task identifier | Links to the primary task entity. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the task is currently active. |
| create_date | TIMESTAMP | true | Record creation timestamp | Ingestion or system creation time. |
| date_assign | TIMESTAMP | true | Assignment timestamp | When the task was assigned to the user. |
| date_end | TIMESTAMP | true | Completion timestamp | When the task was marked as finished. |
| date_last_stage_update | TIMESTAMP | true | Last stage change timestamp | Tracks movement through the project workflow. |
| date_deadline | TIMESTAMP | true | Deadline timestamp | Target completion date. |
| project_id | INTEGER | true | Project identifier | Links to the parent project. |
| priority | VARCHAR | true | Task priority level | Often represented as a string or code. |
| name | VARCHAR | true | Task description/title | Human-readable name of the task. |
| company_id | INTEGER | true | Company identifier | Multi-tenant identifier for the organization. |
| partner_id | INTEGER | true | Customer/Partner identifier | The client or partner associated with the task. |
| parent_id | INTEGER | true | Parent task identifier | Used for hierarchical task structures. |
| stage_id | INTEGER | true | Workflow stage identifier | Current status in the project pipeline. |
| state | VARCHAR | true | Task state | Current lifecycle status (e.g., 'done', 'draft'). |
| milestone_id | INTEGER | true | Milestone identifier | Links to a project milestone. |
| is_closed | BOOLEAN | true | Completion status | Flag indicating if the task is finalized. |
| has_late_and_unreached_milestone | BOOLEAN | true | Milestone delay flag | Indicates if associated milestones are overdue. |
| description | TEXT | true | Detailed task notes | Full text description of the task requirements. |
| rating_last_value | DOUBLE PRECISION | true | Last rating score | Most recent feedback score. |
| rating_avg | DOUBLE PRECISION | true | Average rating score | Aggregated feedback score. |
| working_days_close | DOUBLE PRECISION | true | Days to close | Duration in days to complete the task. |
| working_days_open | DOUBLE PRECISION | true | Days open | Duration in days the task has been active. |
| working_hours_open | NUMERIC | true | Hours open | Duration in hours the task has been active. |
| working_hours_close | NUMERIC | true | Hours to close | Duration in hours to complete the task. |
| delay_endings_days | NUMERIC | true | Delay duration | Number of days past the deadline. |
| dependent_ids_count | BIGINT | true | Dependency count | Number of tasks dependent on this one. |
| sale_line_id | INTEGER | true | Sales order line identifier | Links to the specific sales line item. |
| sale_order_id | INTEGER | true | Sales order identifier | Links to the originating sales order. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `project_id` → `project.id` (Standard Odoo project link)
    - `partner_id` → `res_partner.id` (Standard Odoo partner link)
    - `sale_order_id` → `sale_order.id` (Standard Odoo sales link)
    - `stage_id` → `project_task_type.id` (Standard Odoo workflow stage link)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `description` column may contain PII or internal notes; ensure appropriate masking if exposed to non-authorized users.
- **Timezones:** Timestamps are assumed to be in UTC, but verify against the source Odoo configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = TRUE` unless historical analysis is required.
- **Data Quality:** As a staging table, expect potential nulls in foreign key fields if tasks are not linked to specific sales orders or partners.