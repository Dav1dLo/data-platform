# resource_resource

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date` audit columns, as well as the `resource_resource` table structure commonly found in Odoo's resource management module.

## Functional process 
This table supports the Resource Management process, which tracks internal assets, employees, or equipment available for scheduling and capacity planning. It links resources to specific companies and calendars, facilitating operations like project task allocation, manufacturing capacity planning, or service scheduling.

## Description
One row in this table represents a single resource entity (such as a person, machine, or workspace) available for operational tasks. It serves as a raw landed copy from the source system, providing the foundational definition of resources, their time zones, and their relative efficiency factors for scheduling calculations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `resource_resource_id_seq` sequence. |
| company_id | INTEGER | true | Foreign key to the owning company | Links to the organizational entity. |
| user_id | INTEGER | true | Foreign key to the associated system user | Links to the user account if the resource is a person. |
| calendar_id | INTEGER | true | Foreign key to the working time calendar | Defines the resource's availability schedule. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit field. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Audit field. |
| name | VARCHAR | false | Display name of the resource | Descriptive label. |
| resource_type | VARCHAR | false | Category of the resource | e.g., 'user', 'material', 'equipment'. |
| tz | VARCHAR | false | Timezone string | IANA timezone identifier (e.g., 'UTC'). |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the resource is currently enabled. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| time_efficiency | DOUBLE PRECISION | false | Efficiency factor | Multiplier for capacity (e.g., 1.0 = 100%). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `user_id` → `res_users.id` (Standard Odoo user association).
    - `calendar_id` → `resource_calendar.id` (Standard Odoo scheduling link).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve only currently valid resources.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database practices.
- **Efficiency:** The `time_efficiency` column is a multiplier; a value of 1.0 represents standard capacity, while values < 1.0 indicate lower productivity or availability.
- **PII:** The `name` column may contain personal identifiable information if the resource is a human employee.