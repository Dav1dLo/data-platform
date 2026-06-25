# ir_model_spreadsheet_dashboard_rel

## Source system
This table likely originates from an Odoo ERP environment, as indicated by the `ir_model_` naming convention, which is standard for Odoo's internal registry (Information Registry) tables.

## Functional process 
This table supports the configuration and linking of dashboard components within the Odoo framework. It manages the many-to-many relationship between spreadsheet dashboard definitions and the underlying data models they reference.

## Description
One row represents a single association between a specific spreadsheet dashboard and an Odoo data model. This is a junction table used to resolve a many-to-many relationship, serving as a raw landing copy of the system's internal relational mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| spreadsheet_dashboard_id | INTEGER | false | Foreign key to the spreadsheet dashboard definition | Represents the parent dashboard entity. |
| ir_model_id | INTEGER | false | Foreign key to the Odoo data model | References the specific model being displayed. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`spreadsheet_dashboard_id`, `ir_model_id`).
- **Foreign keys (inferred):** 
    - `spreadsheet_dashboard_id` → `spreadsheet_dashboard.id` (Guess: links to the dashboard definition table).
    - `ir_model_id` → `ir_model.id` (Guess: links to the standard Odoo model registry table).
- **Natural keys (inferred):** The combination of (`spreadsheet_dashboard_id`, `ir_model_id`) acts as the unique business identifier for the relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present to track when these relationships were created or modified.
- Ensure that joins to the target tables handle potential orphans if the source system performs hard deletes on the parent entities.