# project_task_type_rel

## Source system
The table likely originates from a project management or task-tracking operational system (e.g., Jira, Asana, or a custom internal tool). The naming convention `_rel` strongly suggests a junction table used to resolve a many-to-many relationship between project entities and task type definitions.

## Functional process 
This table supports the configuration of project-specific task workflows or taxonomies. It defines which task types are permitted or enabled for a given project, ensuring that users can only select relevant task categories (e.g., "Bug", "Feature", "Task") when working within a specific project context.

## Description
One row in this table represents a single association between a project and a specific task type. It serves as a raw landing copy of a join table, maintaining the link between project identifiers and their corresponding task type definitions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_id | INTEGER | false | Unique identifier for the project. | Foreign key to the projects table. |
| type_id | INTEGER | false | Unique identifier for the task type. | Foreign key to the task_types table. |

## Keys

- **Primary key (inferred):** The combination of `(project_id, type_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `project_id` → `projects.id`: Evidence is the `_id` suffix and standard relational modeling for junction tables.
    - `type_id` → `task_types.id`: Evidence is the `_id` suffix and the context of defining task types.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries should expect to join this with both the `projects` and `task_types` tables to retrieve human-readable names.
- There are no timestamps or audit columns; it is impossible to determine the creation or modification date of these relationships from this table alone.
- The table contains no soft-delete flags; assume that the absence of a record implies the relationship does not exist.