# calendar_event_type

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a signature pattern for Odoo's ORM-based audit tracking, and the table name aligns with Odoo's calendar module structure.

## Functional process 
This table supports the configuration of calendar event categories or types, allowing users to classify meetings or appointments (e.g., "Internal Meeting", "Client Call", "Personal"). It acts as a lookup table for the broader scheduling and resource management process within the application.

## Description
One row represents a single definition of a calendar event type, including its display label and associated UI color. This is a raw landing table in the staging layer, capturing the configuration state of event classifications as defined in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `calendar_event_type_id_seq`. |
| color | INTEGER | true | UI color index | Represents an integer mapping to a color palette in the frontend. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated this record. |
| name | VARCHAR | false | Event type label | The human-readable name of the event category. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the source system; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern for user references).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern for user references).
- **Natural keys (inferred):** 
    - `name` (assuming event type names are unique within the system configuration).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are provided by the source system; assume UTC unless the source environment configuration dictates otherwise.
- **Audit columns:** `create_uid` and `write_uid` refer to internal system user IDs; these may not resolve if the `res_users` table is not available in the same schema.
- **Data volatility:** As a staging table, this may contain historical configuration states if the ingestion process performs full dumps rather than incremental updates.
- **Soft deletes:** There is no explicit `active` or `deleted_at` flag; check if the source system uses a boolean `active` column (not present here) to filter out inactive types.