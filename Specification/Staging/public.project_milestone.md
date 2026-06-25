# project_milestone

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a standard pattern for Odoo's ORM audit fields, and the naming convention for the sequence `project_milestone_id_seq` is characteristic of PostgreSQL-backed Odoo installations.

## Functional process 
This table supports the project management and billing process, specifically tracking progress milestones within a project. It links project deliverables to sales orders via `sale_line_id` and tracks completion status through `is_reached` and `reached_date`, facilitating progress-based billing or project reporting.

## Description
One row represents a single milestone associated with a specific project, defining a target deadline and completion status. As a staging table, it serves as a raw, direct copy of the source system's milestone entity, intended for downstream transformation into project management or revenue recognition models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `project_milestone_id_seq`. |
| project_id | INTEGER | false | Foreign key to the parent project | Links to the project entity. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | false | Milestone name or description | Human-readable label. |
| deadline | DATE | true | Target date for milestone completion | |
| reached_date | DATE | true | Actual date the milestone was achieved | |
| is_reached | BOOLEAN | true | Completion status flag | |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |
| sale_line_id | INTEGER | true | Foreign key to sales order line | Links milestone to specific billing items. |
| quantity_percentage | DOUBLE PRECISION | true | Progress completion percentage | Represented as a decimal (e.g., 0.5 for 50%). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `project_id` → `project.id` (Inferred from naming convention).
    - `sale_line_id` → `sale_order_line.id` (Inferred from naming convention).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Data Integrity:** `is_reached` may not always be in sync with `reached_date`; query logic should account for potential discrepancies where a date is set but the boolean is false, or vice versa.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag, suggesting it may contain only active records or that deletions are hard-deleted in the source.
- **Sensitivity:** `create_uid` and `write_uid` refer to internal system users; ensure these are joined against the appropriate user dimension to avoid exposing internal IDs.