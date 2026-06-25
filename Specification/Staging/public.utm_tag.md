# utm_tag

## Source system
This table originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences and `JSONB` for localized fields, is characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports the marketing attribution and campaign tracking process. It stores definitions for UTM tags used to categorize traffic sources, mediums, and campaigns, allowing the business to track the effectiveness of various marketing channels.

## Description
One row in this table represents a single UTM tag definition used for tracking marketing performance. It serves as a raw landed copy of the tag configuration from the source system, stored at the grain of one unique tag identifier per row.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.utm_tag_id_seq` sequence. |
| color | INTEGER | true | UI color index | Used for visual categorization in the Odoo dashboard. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the tag. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the tag. |
| name | JSONB | false | Tag name | Likely contains localized strings for the tag label. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `name` (Assuming the JSONB content acts as the unique business identifier for the tag).

## Caveats for downstream consumers

- The `name` column is `JSONB`; ensure you use the `->>` operator to extract text values for filtering or grouping (e.g., `name->>'en_US'`).
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table contains no explicit soft-delete flag; assume all rows are active unless otherwise specified by business logic.
- The `color` column is an integer index and does not map to a specific hex code without referencing the Odoo UI configuration.