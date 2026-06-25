# calendar_recurrence

## Source system
The table likely originates from an Odoo or similar ERP/CRM system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific structure of recurrence fields (`rrule`, `rrule_type`, `byday`) which mirror standard iCalendar (RFC 5545) implementations used in those platforms.

## Functional process 
This table supports the scheduling and calendar management module, specifically the logic for recurring events. It defines the frequency and duration patterns for events that repeat over time, allowing the system to calculate future occurrences based on the provided `rrule` (Recurrence Rule) and boolean day flags.

## Description
One row in this table represents a single recurrence definition linked to a base calendar event. It acts as a raw staging entity that stores the configuration parameters required to expand a recurring event into individual calendar entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `calendar_recurrence_id_seq`. |
| base_event_id | INTEGER | true | Reference to the parent event | Likely links to a `calendar_event` table. |
| interval | INTEGER | true | Recurrence frequency interval | e.g., "every 2 weeks". |
| count | INTEGER | true | Number of occurrences | Used if the recurrence is limited by count. |
| day | INTEGER | true | Specific day of the month | Used for monthly recurrence patterns. |
| trigger_id | INTEGER | true | Trigger reference | Likely links to an automation or notification trigger. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | VARCHAR | true | Recurrence name | Descriptive label for the recurrence rule. |
| event_tz | VARCHAR | true | Timezone | IANA timezone string (e.g., 'UTC'). |
| rrule | VARCHAR | true | iCalendar RRULE string | The full RFC 5545 recurrence rule. |
| rrule_type | VARCHAR | true | Recurrence type | e.g., 'daily', 'weekly', 'monthly'. |
| end_type | VARCHAR | true | Termination condition | e.g., 'count', 'until', 'forever'. |
| month_by | VARCHAR | true | Monthly recurrence logic | e.g., 'date' or 'day'. |
| weekday | VARCHAR | true | Day of the week | Used for weekly recurrence logic. |
| byday | VARCHAR | true | By-day rule | Specific day constraints (e.g., '1MO' for first Monday). |
| until | DATE | true | End date | The date after which the recurrence stops. |
| mon | BOOLEAN | true | Monday flag | Weekly recurrence flag. |
| tue | BOOLEAN | true | Tuesday flag | Weekly recurrence flag. |
| wed | BOOLEAN | true | Wednesday flag | Weekly recurrence flag. |
| thu | BOOLEAN | true | Thursday flag | Weekly recurrence flag. |
| fri | BOOLEAN | true | Friday flag | Weekly recurrence flag. |
| sat | BOOLEAN | true | Saturday flag | Weekly recurrence flag. |
| sun | BOOLEAN | true | Sunday flag | Weekly recurrence flag. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `base_event_id` → `calendar_event.id` (Guess: links to the parent event definition).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag; assume all rows are currently active unless filtered by business logic.
- **Data Integrity:** The boolean flags (`mon` through `sun`) and the `rrule` string may contain redundant information; ensure your query logic accounts for potential discrepancies between these fields.
- **Sensitive Data:** No PII is immediately obvious, but `create_uid` and `write_uid` link to user identity tables which may contain sensitive information.