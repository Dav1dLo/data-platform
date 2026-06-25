# utm_stage

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework, as evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo models. The use of a `JSONB` column for `name` suggests a flexible schema implementation for tracking marketing campaign stages or UTM-related metadata.

## Functional process 
This table supports the marketing automation or lead management process, specifically tracking the lifecycle stages of UTM (Urchin Tracking Module) campaigns. It likely serves as a staging area for campaign configuration or tracking definitions used to categorize incoming traffic sources and marketing efforts.

## Description
One row in this table represents a single UTM stage definition or configuration record. It acts as a raw landing copy of the source system's campaign stage entity, maintaining audit trails for creation and modification. The grain is one row per unique stage identifier.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.utm_stage_id_seq`. |
| sequence | INTEGER | true | Sort order index | Used to define the display or processing order of stages. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system's user table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system's user table. |
| name | JSONB | false | Stage name/metadata | Likely contains localized names or structured configuration. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is `JSONB`; ensure your queries use appropriate PostgreSQL JSON operators (e.g., `->>` or `->`) to extract values.
- Timestamps (`create_date`, `write_date`) are assumed to be in the source system's timezone (typically UTC for Odoo-based systems), but verify against application settings.
- This is a staging table; it may contain duplicate records or incomplete data depending on the ingestion frequency and source system state.
- No explicit soft-delete flag is present; assume all rows are active unless the source system logic dictates otherwise.