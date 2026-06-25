# onboarding_progress_onboarding_progress_step_rel

## Source system
Unknown — insufficient evidence. The table name follows a standard junction table naming convention often found in ORM-generated schemas (e.g., Django or SQLAlchemy), but the specific operational system cannot be determined from the provided metadata.

## Functional process 
This table supports the user onboarding lifecycle by managing the many-to-many relationship between high-level onboarding progress records and specific onboarding steps. It tracks which individual steps have been associated with a particular progress instance.

## Description
One row in this table represents a single association between an onboarding progress record and an onboarding step. It serves as a raw landing junction table in the staging layer, facilitating the resolution of many-to-many relationships between the progress and step entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| onboarding_progress_id | INTEGER | false | Foreign key to the onboarding progress record | Links to the parent onboarding session. |
| onboarding_progress_step_id | INTEGER | false | Foreign key to the specific onboarding step | Identifies the step associated with the progress. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table likely uses a composite primary key consisting of `(onboarding_progress_id, onboarding_progress_step_id)`.
- **Foreign keys (inferred):** 
    - `onboarding_progress_id` → `onboarding_progress.id` (Guess: links to the main progress entity).
    - `onboarding_progress_step_id` → `onboarding_progress_step.id` (Guess: links to the definition of the onboarding step).
- **Natural keys (inferred):** The combination of `(onboarding_progress_id, onboarding_progress_step_id)` acts as the unique business identifier for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present to track when these associations were created.
- Ensure joins are performed on both columns to avoid Cartesian products when querying the relationship.