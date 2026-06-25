# mail_activity_plan_mail_activity_schedule_rel

## Source system
This table originates from an Odoo ERP environment, as indicated by the naming convention `_rel` suffix and the specific pattern of linking two distinct business entities (`mail_activity_plan` and `mail_activity_schedule`) via a join table.

## Functional process 
This table supports the automated marketing or communication workflow process, specifically managing the relationship between activity plans (templates or sequences of actions) and scheduled mail activities. It facilitates the many-to-many mapping required to associate specific communication schedules with defined activity plans.

## Description
One row in this table represents a single association between a mail activity plan and a mail activity schedule. As a staging table, it serves as a raw, landed copy of the link table from the source database, maintaining the relational integrity between these two entities before any downstream transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_activity_schedule_id | INTEGER | false | Foreign key to the mail activity schedule entity | Links to the schedule definition. |
| mail_activity_plan_id | INTEGER | false | Foreign key to the mail activity plan entity | Links to the plan definition. |

## Keys

- **Primary key (inferred):** The composite of (`mail_activity_schedule_id`, `mail_activity_plan_id`).
- **Foreign keys (inferred):** 
    - `mail_activity_schedule_id` → `mail_activity_schedule.id`: Guessed based on the standard Odoo naming convention for relational tables.
    - `mail_activity_plan_id` → `mail_activity_plan.id`: Guessed based on the standard Odoo naming convention for relational tables.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- Ensure that joins to the parent tables handle potential orphan records if the source system's referential integrity is not strictly enforced.
- This table does not contain audit timestamps (e.g., `created_at`), so tracking the history of these associations is not possible from this table alone.