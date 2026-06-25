# mrp_routing_workcenter_dependencies_rel

## Source system
This table likely originates from an ERP system such as Odoo or a similar manufacturing execution system (MES). The naming convention `mrp_` (Manufacturing Resource Planning) combined with a relationship table suffix `_rel` is characteristic of modular ERP architectures that manage production routing dependencies.

## Functional process 
This table supports the production scheduling and manufacturing routing process. It defines the sequence constraints between different operations within a workcenter routing, ensuring that specific manufacturing steps cannot commence until their prerequisite operations are completed.

## Description
Each row represents a dependency relationship between two manufacturing operations within a routing sequence. It acts as a link table in a many-to-many relationship, mapping an operation to the specific operation that must be completed before it can begin. This is a raw staging table representing a direct extract of the dependency mapping from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| operation_id | INTEGER | false | The identifier of the dependent operation. | References the primary operation in the routing. |
| blocked_by_id | INTEGER | false | The identifier of the prerequisite operation. | The operation that must finish before `operation_id` can start. |

## Keys

- **Primary key (inferred):** The combination of (`operation_id`, `blocked_by_id`) is inferred as the composite primary key.
- **Foreign keys (inferred):** 
    - `operation_id` → `mrp_routing_operation.id` (guess: links to the operation definition table).
    - `blocked_by_id` → `mrp_routing_operation.id` (guess: links to the prerequisite operation definition table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries will likely require joining back to the main operation table twice to resolve the human-readable names of the operations.
- There is no explicit timestamp or audit metadata provided; assume this represents the current state of dependencies as of the last ingestion.
- Ensure that queries account for potential circular dependencies if the source system does not enforce strict acyclic graph validation at the database level.