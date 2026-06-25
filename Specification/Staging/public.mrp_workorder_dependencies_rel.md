# mrp_workorder_dependencies_rel

## Source system
The table likely originates from an ERP or Manufacturing Execution System (MES) such as Odoo or a similar modular manufacturing suite. The naming convention `mrp_` (Material Requirements Planning) and the `_rel` suffix are characteristic of relational join tables used in systems to manage many-to-many associations between manufacturing entities.

## Functional process 
This table supports the production scheduling and dependency management process. It defines the sequence of operations by identifying which work orders must be completed before another can begin, effectively mapping the directed acyclic graph (DAG) of a manufacturing production plan.

## Description
One row in this table represents a single dependency relationship where one work order is blocked by the completion of another. This is a raw landing table in the staging layer, capturing the direct link between a dependent work order and its prerequisite.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| workorder_id | INTEGER | false | The ID of the work order that is being blocked. | References the primary work order entity. |
| blocked_by_id | INTEGER | false | The ID of the work order that must be completed first. | The prerequisite work order. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(workorder_id, blocked_by_id)`.
- **Foreign keys (inferred):** 
    - `workorder_id` → `mrp_workorder.id` (guess: standard naming convention for work order references).
    - `blocked_by_id` → `mrp_workorder.id` (guess: the prerequisite must also be a valid work order).
- **Natural keys (inferred):** The combination of `(workorder_id, blocked_by_id)` acts as the business key for the dependency relationship.

## Caveats for downstream consumers

- This table represents a many-to-many relationship; expect multiple rows per `workorder_id` if a task has multiple prerequisites.
- There is no explicit timestamp or audit metadata; the current state reflects the latest snapshot from the source system.
- Ensure that queries account for potential circular dependencies if the source system does not enforce strict validation at the application level.