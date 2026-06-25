# merge_opportunity_rel

## Source system
The table likely originates from a CRM system such as Salesforce or Microsoft Dynamics, where opportunity records are managed. The naming convention `merge_opportunity_rel` suggests an association table used to track the merging of duplicate or related sales opportunities.

## Functional process 
This table supports the data integrity and deduplication process within the sales pipeline. It maps the relationship between a master merge record and the specific opportunities involved in that merge, ensuring that sales history and pipeline metrics remain consistent when records are consolidated.

## Description
One row in this table represents a single association between a merge event and an opportunity record. It serves as a raw landing copy of a join table, capturing the link between a specific merge operation and the opportunities that were processed or consolidated during that event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| merge_id | INTEGER | false | Unique identifier for the merge event. | Acts as the foreign key to the merge header table. |
| opportunity_id | INTEGER | false | Unique identifier for the opportunity. | Acts as the foreign key to the opportunities table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`merge_id`, `opportunity_id`).
- **Foreign keys (inferred):**
    - `merge_id` → `merge_header.id` (guess: links to the record defining the merge event).
    - `opportunity_id` → `opportunity.id` (guess: links to the specific opportunity record being merged).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between merge events and opportunities.
- No audit timestamps (e.g., `created_at`) are present, so it is impossible to determine the sequence of merges from this table alone.
- The table contains only surrogate integer keys; no business-level identifiers (like `opportunity_number` or `email`) are available for direct validation.