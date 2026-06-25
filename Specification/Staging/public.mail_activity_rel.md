# mail_activity_rel

## Source system
The table likely originates from a CRM or marketing automation platform (such as Odoo or a similar relational marketing suite), given the naming convention `_rel` which typically denotes a join table in ORM-based database schemas. The evidence is moderate, suggesting a link between email/marketing activities and specific recommendations or content items.

## Functional process 
This table supports the tracking of marketing engagement, specifically mapping email-based activities to the content or product recommendations presented to the user. It facilitates the analysis of which specific recommendations were served within a given marketing activity.

## Description
One row in this table represents a single association between a marketing activity and a recommendation. It acts as a junction table at the grain of a many-to-many relationship, serving as a raw landed copy of the link between these two entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| activity_id | INTEGER | false | Foreign key to the parent marketing activity | Represents the source event or email campaign. |
| recommended_id | INTEGER | false | Foreign key to the recommendation entity | Represents the specific item or content recommended. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`activity_id`, `recommended_id`).
- **Foreign keys (inferred):** 
    - `activity_id` → `mail_activity.id` (guess: standard naming convention for activity tracking).
    - `recommended_id` → `recommendation.id` (guess: standard naming convention for recommendation entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many relationships.
- No audit timestamps (e.g., `created_at`) are present, so the temporal order of associations cannot be determined from this table alone.
- There are no soft-delete flags; assume this table contains the current state of associations as captured during the last ingestion.