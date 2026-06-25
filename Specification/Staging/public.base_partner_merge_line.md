# base_partner_merge_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `base_partner_merge_line`, `wizard_id`, `create_uid`, `write_uid`) is characteristic of Odoo's internal ORM structure, specifically related to the partner deduplication wizard.

## Functional process 
This table supports the "Partner Deduplication" business process. It tracks the individual lines or records involved in a merge operation, where multiple duplicate partner records are identified and consolidated into a single master record.

## Description
One row in this table represents a single entry within a partner merge operation, linking a specific partner record to a merge wizard session. It serves as a raw landing copy of the Odoo `base.partner.merge.line` model, capturing the state of records being processed for consolidation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_partner_merge_line_id_seq`. |
| wizard_id | INTEGER | true | Foreign key to the merge wizard | Links to the parent merge operation. |
| min_id | INTEGER | true | Minimum partner ID in the merge set | Often used to identify the target master record. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users`. |
| aggr_ids | VARCHAR | false | Aggregated partner IDs | Likely a comma-separated string of IDs being merged. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `base_partner_merge_line.id` (guess: links to the parent merge wizard session).
    - `create_uid` → `res_users.id` (guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `aggr_ids` column contains a string representation of multiple IDs; this will require parsing (e.g., `string_to_array`) to use in join operations.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table is a staging artifact; it may contain transient data related to active or completed wizard sessions and should not be treated as a permanent record of truth for partner entities.