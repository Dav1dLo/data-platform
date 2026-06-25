# web_tour_tour_step

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `web_tour_tour_step` combined with audit columns like `create_uid` and `write_uid` is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the "Guided Tour" or "Onboarding" feature within the Odoo web interface. It defines the individual steps that a user encounters during an interactive product tour, including the sequence of actions, the specific UI triggers, and the content displayed to the user.

## Description
One row represents a single step within a defined product tour. It stores the configuration for how a specific step behaves, including its order in the sequence and the JavaScript code or trigger conditions required to execute it. This is a raw staging table representing a direct dump of the Odoo application database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| tour_id | INTEGER | false | Foreign key to the parent tour | Links this step to a specific tour definition. |
| sequence | INTEGER | true | Display order | Determines the order in which steps appear. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this step. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this step. |
| trigger | VARCHAR | false | UI selector/event | The CSS selector or event that triggers this step. |
| content | VARCHAR | true | Step description | The text content displayed to the user during the tour. |
| run | VARCHAR | true | Execution script | JavaScript code or command to run for this step. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `tour_id` → `web_tour_tour.id` (Inferred from standard Odoo naming conventions where `_id` suffixes denote relations to the parent object).
    - `create_uid` → `res_users.id` (Standard Odoo audit relation).
    - `write_uid` → `res_users.id` (Standard Odoo audit relation).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo application server's timezone (typically UTC), but verify against the `res_company` settings if precision is required.
- **Soft Deletes:** Odoo does not typically use soft deletes; rows are usually physically removed from the table.
- **Data Integrity:** As a staging table, this may contain orphaned records if the parent `web_tour_tour` record was deleted without cascading.
- **Content:** The `content` and `run` columns may contain HTML or JavaScript snippets; sanitize if rendering in a web-based reporting tool.