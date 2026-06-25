# res_users_web_tour_tour_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_users_web_tour_tour_rel` is characteristic of Odoo's internal relational mapping tables, specifically linking user records (`res_users`) to web tour progress or completion states (`web_tour_tour`).

## Functional process 
This table supports the user onboarding and guided tour tracking process. It maps which users have interacted with or completed specific web-based guided tours within the application interface, facilitating the "show tour only once" or "track progress" functionality.

## Description
One row in this table represents a many-to-many relationship between a specific system user and a web tour. It serves as a raw landing copy of the association table used by the Odoo web client to persist tour state across sessions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| web_tour_tour_id | INTEGER | false | Foreign key to the web tour definition | Represents the unique identifier of the tour. |
| res_users_id | INTEGER | false | Foreign key to the user record | Represents the unique identifier of the user. |

## Keys

- **Primary key (inferred):** The composite of `(web_tour_tour_id, res_users_id)`.
- **Foreign keys (inferred):** 
    - `web_tour_tour_id` → `web_tour_tour.id`: This column references the master list of available web tours.
    - `res_users_id` → `res_users.id`: This column references the system user account.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `created_at`) available in this table, so it is impossible to determine when the relationship was established.
- Queries should expect this table to be used primarily for `JOIN` operations to filter users by their tour interaction history.