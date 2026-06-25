# project_favorite_user_rel

## Source system
The source system is likely an internal application database, such as a custom-built project management or collaboration platform. The naming convention `project_favorite_user_rel` strongly suggests a junction table used to manage a many-to-many relationship between users and projects within a web application backend.

## Functional process 
This table supports the "User Preferences" or "Project Bookmarking" business process. It tracks which users have marked specific projects as "favorites" or "starred" items, enabling personalized views and quick-access navigation within the application interface.

## Description
One row in this table represents a single association between a user and a project, indicating that the user has favorited the project. As a staging table, it serves as a raw, landed copy of the relationship mapping extracted directly from the operational database to facilitate downstream analytical reporting on user engagement and project popularity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| project_id | INTEGER | false | Unique identifier of the favorited project | Foreign key to the projects master table. |
| user_id | INTEGER | false | Unique identifier of the user who favorited the project | Foreign key to the users master table. |

## Keys

- **Primary key (inferred):** Composite key of (`project_id`, `user_id`).
- **Foreign keys (inferred):** 
    - `project_id` → `projects.id`: This column references the primary project entity.
    - `user_id` → `users.id`: This column references the primary user entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes other than the relationship itself.
- There are no audit timestamps (e.g., `created_at`) available in this staging layer, so it is impossible to determine when a favorite was added or removed based on this table alone.
- The table does not explicitly handle soft deletes; if a record is missing from this table, it is assumed the relationship no longer exists in the source system.