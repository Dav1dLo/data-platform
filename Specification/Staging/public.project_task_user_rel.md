# project_task_user_rel

## Source system
The table likely originates from an Odoo ERP or a similar modular business management system. The naming convention `_rel` (relationship), the use of `create_uid`/`write_uid` audit columns, and the sequence-based `id` are characteristic patterns of Odoo's ORM-generated join tables.

## Functional process 
This table supports the project management module by maintaining the many-to-many relationship between tasks and users. It tracks task assignments and potentially the progression of users through specific task stages, facilitating resource allocation and project tracking.

## Description
One row in this table represents a single association between a specific project task and a user, defining their involvement or assignment. As a staging table, it serves as a raw, landed copy of the relational mapping data, intended for integration into downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `project_task_user_rel_id_seq`. |
| task_id | INTEGER | false | Foreign key to the task | Links to the project task entity. |
| user_id | INTEGER | false | Foreign key to the user | Links to the assigned user entity. |
| stage_id | INTEGER | true | Foreign key to the task stage | Represents the specific phase or status of the user's involvement. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone unspecified. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone unspecified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `task_id` → `project_task.id` (Inferred from standard Odoo naming conventions).
    - `user_id` → `res_users.id` (Inferred from standard Odoo naming conventions).
    - `stage_id` → `project_task_type.id` (Inferred from standard Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are provided as-is from the source; verify if the source system stores these in UTC or local server time.
- This table is a join table; expect high cardinality and frequent updates if task assignments change often.
- No PII is explicitly identified, but `user_id` links to sensitive user identity data in other tables.
- The table does not implement soft deletes; records are typically hard-deleted in this Odoo pattern.