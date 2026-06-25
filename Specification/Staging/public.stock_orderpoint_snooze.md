# stock_orderpoint_snooze

## Source system
This table likely originates from an Odoo ERP instance. The naming convention (`stock_orderpoint_snooze`), the use of `create_uid`/`write_uid` for audit tracking, and the specific sequence pattern `nextval('"public".stock_orderpoint_snooze_id_seq'::regclass)` are characteristic of Odoo's ORM-generated database schema.

## Functional process 
This table supports inventory management and replenishment processes. It tracks "snooze" configurations for stock order points, allowing users to temporarily suppress or delay automated replenishment triggers for specific inventory items until a defined date.

## Description
One row represents a single snooze configuration applied to a stock order point, defining a period during which automated replenishment alerts are paused. This is a raw landing table in the staging layer, containing a direct copy of the source system's snooze settings used to manage inventory reordering logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-increment. |
| create_uid | INTEGER | true | User ID who created the record | References the system's user directory. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system's user directory. |
| predefined_date | VARCHAR | true | Predefined snooze duration or label | Likely stores a string representation of a snooze interval. |
| snoozed_until | DATE | true | The date until which the order point is snoozed | The effective end date of the snooze period. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- The `predefined_date` column is a `VARCHAR` and may contain inconsistent string formats or localized labels; validate data quality before using for date arithmetic.
- This table does not explicitly show a link to the `stock.orderpoint` table; downstream joins may require identifying the linking column (often `orderpoint_id` in Odoo schemas) if it exists in the source but is missing here.
- No soft-delete flag is present; assume records are either hard-deleted or managed via the `snoozed_until` date logic.