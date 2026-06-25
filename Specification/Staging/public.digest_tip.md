# digest_tip

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for localized fields (`name`, `tip_description`) are characteristic patterns of Odoo's PostgreSQL-based backend.

## Functional process 
This table supports the "Digest" or "Email Marketing" module, specifically managing the content of tips or informational snippets sent to users. It tracks the sequence and content of these tips, likely used to populate automated periodic summary emails or dashboard notifications.

## Description
One row in this table represents a single informational tip or content snippet available for inclusion in digest communications. It is a raw landing copy of the Odoo `digest.tip` model, stored at the grain of one row per tip definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `digest_tip_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort tips in UI or email lists. |
| group_id | INTEGER | true | Foreign key to digest group | Links the tip to a specific digest category. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | JSONB | true | Tip title | Likely contains localized strings. |
| tip_description | JSONB | true | Tip content body | Likely contains localized HTML or text content. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `group_id` → `digest_group.id` (Guess: links to a parent digest configuration group).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `name` and `tip_description` columns are `JSONB` types; you will need to use PostgreSQL JSON operators (e.g., `->>` or `jsonb_extract_path_text`) to access the actual text values.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage.
- This table contains audit fields (`create_uid`, `write_uid`) which may link to sensitive user account information in the `res_users` table.
- No soft-delete flag is present; assume standard CRUD operations.