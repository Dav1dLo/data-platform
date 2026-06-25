# hr_department

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `parent_path`, `JSONB` for names) and the specific sequence generator pattern are characteristic of the Odoo framework's internal data structure for managing organizational hierarchies.

## Functional process 
This table supports the Human Resources organizational structure management. It defines the hierarchy of departments within the company, tracking reporting lines via `manager_id` and `parent_id`, and maintaining the organizational tree structure through `parent_path`.

## Description
One row represents a single department or organizational unit within the company. This is a raw landing table in the staging layer, containing the current state of department definitions, including localized names stored as JSONB and audit metadata for tracking record creation and updates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `hr_department_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Links to the owning company entity. |
| parent_id | INTEGER | true | Parent department ID | Used for recursive hierarchy. |
| manager_id | INTEGER | true | Manager employee ID | Links to the employee in charge. |
| color | INTEGER | true | UI display color index | Used for frontend visualization. |
| master_department_id | INTEGER | true | Master department reference | Used for grouping or roll-up reporting. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| complete_name | VARCHAR | true | Full hierarchical name | Denormalized path (e.g., "Parent/Child"). |
| parent_path | VARCHAR | true | Materialized path | Used for efficient tree traversal. |
| name | JSONB | false | Department name | Multi-language support; requires JSON extraction. |
| note | TEXT | true | Internal description | Free-text field for department details. |
| active | BOOLEAN | true | Soft-delete flag | If false, the department is archived. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
    - `parent_id` → `hr_department.id` (Self-referencing hierarchy).
    - `manager_id` → `hr_employee.id` (Guess: standard Odoo HR link).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column is stored as `JSONB`. Use `name->>'en_US'` or similar syntax to extract specific language values.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical analysis is required.
- **Timestamps:** `create_date` and `write_date` are stored in the system's native timezone (typically UTC in Odoo).
- **Hierarchy:** Use the `parent_path` column for efficient recursive queries rather than self-joining on `parent_id` where possible.