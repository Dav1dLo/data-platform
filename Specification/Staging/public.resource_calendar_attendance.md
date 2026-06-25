# resource_calendar_attendance

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the `resource_calendar_attendance` entity structure used to define working hours and shifts within Odoo's resource management module.

## Functional process 
This table supports the human resources and project management scheduling process by defining the specific attendance intervals (working hours) associated with a resource calendar. It dictates when employees or resources are expected to be available, supporting time-tracking, capacity planning, and payroll calculations.

## Description
One row in this table represents a single recurring or specific attendance slot (e.g., "Monday 09:00 to 17:00") linked to a specific resource calendar. It serves as a raw landed copy of the Odoo attendance configuration, capturing the temporal constraints for resource availability.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.resource_calendar_attendance_id_seq`. |
| calendar_id | INTEGER | false | Foreign key to the parent calendar | Links to the resource calendar definition. |
| resource_id | INTEGER | true | Foreign key to a specific resource | Optional; if null, the attendance applies to the whole calendar. |
| sequence | INTEGER | true | Display order index | Used for UI sorting of attendance lines. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| name | VARCHAR | false | Descriptive name of the slot | Often a human-readable label for the shift. |
| dayofweek | VARCHAR | false | Day of the week | Typically '0' (Monday) through '6' (Sunday). |
| day_period | VARCHAR | false | Period of the day | e.g., 'morning', 'afternoon'. |
| week_type | VARCHAR | true | Week cycle type | Used for bi-weekly or alternating shift schedules. |
| display_type | VARCHAR | true | UI display category | Used to distinguish line types in the Odoo interface. |
| date_from | DATE | true | Start date of validity | Defines when this attendance rule becomes active. |
| date_to | DATE | true | End date of validity | Defines when this attendance rule expires. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| hour_from | DOUBLE PRECISION | false | Start time (decimal) | Represented as decimal hours (e.g., 9.5 for 09:30). |
| hour_to | DOUBLE PRECISION | false | End time (decimal) | Represented as decimal hours (e.g., 17.0 for 17:00). |
| duration_days | DOUBLE PRECISION | true | Calculated duration in days | Helper field for capacity planning. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `calendar_id` → `resource_calendar.id`: This is the mandatory parent entity for all attendance records.
    - `resource_id` → `resource_resource.id`: This links the attendance to a specific individual or equipment resource.
    - `create_uid` / `write_uid` → `res_users.id`: These link to the system users who performed the audit actions.
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Decimal Time:** `hour_from` and `hour_to` are stored as decimal hours (e.g., 14.5 = 14:30), not as time objects. You must convert these to time intervals for calculation.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a standard soft-delete flag; records are typically hard-deleted or updated in place by the Odoo ORM.
- **Data Integrity:** `resource_id` is nullable, implying that some attendance records are global to a calendar, while others are resource-specific. Ensure your joins account for this optionality.