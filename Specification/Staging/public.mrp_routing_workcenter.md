# mrp_routing_workcenter

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention (`mrp_routing_workcenter`), the presence of `bom_id` (Bill of Materials), and audit fields like `create_uid` and `write_uid` are characteristic of Odoo's internal database schema.

## Functional process 
This table supports the manufacturing routing process, defining the sequence of operations or work centers required to produce a specific Bill of Materials (BOM). It links manufacturing steps to specific work centers and manages the configuration of instructions (worksheets) and time tracking modes for production orders.

## Description
One row represents a single step or work center assignment within a manufacturing routing for a specific Bill of Materials. It acts as a raw landed copy of the Odoo `mrp.routing.workcenter` model, capturing the configuration of production steps, including time calculation modes and associated documentation links.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| workcenter_id | INTEGER | false | Foreign key to the work center | Links to the physical or logical work center. |
| sequence | INTEGER | true | Display order | Determines the order of operations in the routing. |
| bom_id | INTEGER | false | Foreign key to the BOM | Links to the parent Bill of Materials. |
| time_mode_batch | INTEGER | true | Batch size for time calculation | Used when `time_mode` is set to batch. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Operation name | Descriptive name of the routing step. |
| worksheet_type | VARCHAR | true | Type of instruction | Defines the format of the work instruction (e.g., text, google_slide). |
| worksheet_google_slide | VARCHAR | true | URL for instructions | Link to external Google Slide documentation. |
| time_mode | VARCHAR | true | Time calculation method | Defines how cycle time is calculated (e.g., manual, auto). |
| note | TEXT | true | Operational notes | Additional instructions for the operator. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the routing step is currently active. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |
| time_cycle_manual | DOUBLE PRECISION | true | Manual cycle time | Expected duration for the operation in minutes. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Likely target based on Odoo naming conventions).
    - `bom_id` → `mrp_bom.id` (Likely target based on Odoo naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo audit link).
    - `write_uid` → `res_users.id` (Standard Odoo audit link).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column is used for soft deletes. Queries should filter by `WHERE active = TRUE` to retrieve current configurations.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **PII:** While this table contains operational data, `create_uid` and `write_uid` link to user tables which may contain PII; ensure appropriate access controls are applied to joined user records.
- **Data Integrity:** As a staging table, this may contain historical versions of routing configurations; ensure you are joining against the latest `write_date` if deduplication is required.