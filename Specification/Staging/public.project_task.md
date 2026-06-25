# project_task

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming conventions (e.g., `create_uid`, `write_uid`, `partner_id`, `stage_id`) and the presence of `JSONB` fields for properties and history are characteristic of Odoo's ORM-to-PostgreSQL mapping.

## Functional process 
This table supports the Project Management module, specifically the task tracking lifecycle. It manages the assignment, scheduling, and status tracking of individual work items within projects, linking them to partners (customers), sales orders, and milestones.

## Description
One row represents a single task within a project, capturing its current state, priority, and associated metadata. This table serves as a raw landed staging entity, reflecting the state of project tasks as stored in the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| stage_id | INTEGER | true | Foreign key to task stage | Defines the workflow status. |
| project_id | INTEGER | true | Foreign key to project | The parent project container. |
| partner_id | INTEGER | true | Foreign key to partner | The customer or contact associated. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context. |
| color | INTEGER | true | UI color index | Used for Kanban board styling. |
| displayed_image_id | INTEGER | true | Foreign key to image | Reference to an attachment. |
| parent_id | INTEGER | true | Parent task ID | Used for sub-task hierarchies. |
| milestone_id | INTEGER | true | Foreign key to milestone | Links task to project goals. |
| recurrence_id | INTEGER | true | Recurrence rule ID | Links to recurring task definitions. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for updates. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list. |
| access_token | VARCHAR | true | Public access token | Used for portal/external links. |
| name | VARCHAR | false | Task title | The primary identifier/summary. |
| priority | VARCHAR | true | Priority level | Usually '0', '1', etc. |
| state | VARCHAR | false | Current status | Workflow state (e.g., 'done', 'in_progress'). |
| html_field_history | JSONB | true | Change history | Audit log of field changes. |
| task_properties | JSONB | true | Custom properties | Dynamic attributes. |
| description | TEXT | true | Task details | Rich text or markdown content. |
| working_hours_open | NUMERIC | true | Hours to open | Performance metric. |
| working_hours_close | NUMERIC | true | Hours to close | Performance metric. |
| active | BOOLEAN | true | Soft-delete flag | False indicates archived. |
| display_in_project | BOOLEAN | true | Visibility toggle | UI display setting. |
| recurring_task | BOOLEAN | true | Recurrence flag | Indicates if task repeats. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC. |
| date_end | TIMESTAMP | true | Completion date | Null if not finished. |
| date_assign | TIMESTAMP | true | Assignment date | When task was assigned. |
| date_deadline | TIMESTAMP | true | Deadline date | Target completion date. |
| date_last_stage_update | TIMESTAMP | true | Stage change date | Last workflow transition. |
| rating_last_value | DOUBLE PRECISION | true | Last rating score | Customer feedback score. |
| allocated_hours | DOUBLE PRECISION | true | Estimated effort | In hours. |
| working_days_open | DOUBLE PRECISION | true | Days to open | Performance metric. |
| working_days_close | DOUBLE PRECISION | true | Days to close | Performance metric. |
| email_from | VARCHAR | true | Originating email | Used for email-to-task. |
| partner_name | VARCHAR | true | Partner display name | Denormalized from partner. |
| partner_phone | VARCHAR | true | Partner phone number | Denormalized from partner. |
| partner_company_name | VARCHAR | true | Partner company name | Denormalized from partner. |
| sale_order_id | INTEGER | true | Foreign key to sale order | Links task to revenue. |
| sale_line_id | INTEGER | true | Foreign key to sale line | Links task to specific order item. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `project_id` → `project.id` (Links to the parent project)
    - `stage_id` → `project_task_type.id` (Links to the workflow stage)
    - `partner_id` → `res_partner.id` (Links to the customer/contact)
    - `sale_order_id` → `sale_order.id` (Links to the originating sales order)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `email_cc`, `email_from`, `partner_phone`, and `partner_name`. Ensure these are masked if exposing to non-authorized users.
- **Timestamps:** All `date_*` and `*_date` columns are assumed to be in UTC, consistent with Odoo's standard storage format.
- **Soft Deletes:** The `active` boolean column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing historical analysis.
- **Denormalization:** Several fields (e.g., `partner_name`, `partner_phone`) are denormalized from the `res_partner` table and may become stale if the source partner record is updated.