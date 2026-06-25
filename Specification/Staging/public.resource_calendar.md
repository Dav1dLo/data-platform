# resource_calendar

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the specific column structure (e.g., `tz`, `two_weeks_calendar`, `flexible_hours`) are characteristic of Odoo's internal resource management modules.

## Functional process 
This table supports the human resources and scheduling business processes by defining working time calendars. It is used to calculate availability, capacity, and shift patterns for employees or resources, as indicated by fields like `hours_per_day` and `full_time_required_hours`.

## Description
One row in this table represents a single working time calendar definition, which dictates the standard operating hours and timezone for a set of resources. This is a raw landed copy from the source system, serving as the base entity for downstream scheduling and capacity planning models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.resource_calendar_id_seq`. |
| company_id | INTEGER | true | Foreign key to the owning company | Links to the organization entity. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| name | VARCHAR | false | Name of the calendar | Descriptive label for the schedule. |
| tz | VARCHAR | false | Timezone identifier | IANA timezone string (e.g., 'UTC', 'Europe/Brussels'). |
| hours_per_day | NUMERIC | true | Standard working hours per day | Used for capacity calculations. |
| active | BOOLEAN | true | Soft-delete flag | If false, the calendar is archived. |
| two_weeks_calendar | BOOLEAN | true | Bi-weekly schedule toggle | Indicates if the calendar follows a 2-week rotation. |
| flexible_hours | BOOLEAN | true | Flexible hours flag | Indicates if the schedule allows for non-fixed hours. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the ingestion job. |
| full_time_required_hours | DOUBLE PRECISION | true | Full-time equivalent (FTE) hours | Defines the threshold for full-time status. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may link to employee identities.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC as per standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = TRUE` unless historical analysis is required.
- **Data Integrity:** `company_id` is nullable, which may occur if the calendar is defined at a global/system level rather than per-company.