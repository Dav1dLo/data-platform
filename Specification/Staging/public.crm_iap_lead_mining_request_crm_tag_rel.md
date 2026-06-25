# crm_iap_lead_mining_request_crm_tag_rel

## Source system
The table likely originates from a custom CRM or Lead Management application, given the specific naming convention `crm_iap_lead_mining_request`. The structure suggests an internal tool used for tracking lead mining activities and their associated metadata tags.

## Functional process 
This table supports the lead management and categorization process. It functions as a junction table to implement a many-to-many relationship between lead mining requests and descriptive tags, allowing multiple tags to be assigned to a single mining request for segmentation or workflow routing.

## Description
One row in this table represents a single association between a specific lead mining request and a CRM tag. It serves as a raw landing copy of the relationship mapping, ensuring that the many-to-many link between requests and tags is preserved in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Represents the parent entity in the relationship. |
| crm_tag_id | INTEGER | false | Foreign key to the CRM tag definition | Represents the tag entity being associated. |

## Keys

- **Primary key (inferred):** The composite of (`crm_iap_lead_mining_request_id`, `crm_tag_id`).
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id` (Inferred from naming convention).
    - `crm_tag_id` → `crm_tag.id` (Inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a bridge table; queries should perform `INNER JOIN` operations with the parent `crm_iap_lead_mining_request` and `crm_tag` tables to retrieve meaningful business attributes.
- No audit timestamps (e.g., `created_at`) are present, so it is impossible to determine the sequence of tag assignments from this table alone.
- The table does not contain soft-delete flags; assume that the presence of a row indicates an active association.