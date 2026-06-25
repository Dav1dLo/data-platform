# calendar_event

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `res_id`, `res_model`, `create_uid`, `write_uid`) and the specific structure of fields like `opportunity_id` and `recurrence_id` are characteristic of Odoo's `calendar.event` model.

## Functional process 
This table supports the scheduling and coordination business process, managing appointments, meetings, and video calls. It tracks event metadata, recurrence patterns, and links to other business objects (such as CRM opportunities via `opportunity_id` or generic resources via `res_id`/`res_model`).

## Description
One row represents a single calendar event or a specific instance within a recurring series. This is a raw landed copy of the Odoo `calendar_event` table in the staging layer, intended for downstream transformation into analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated |
| user_id | INTEGER | true | Owner of the event | Foreign key to user |
| videocall_channel_id | INTEGER | true | ID of the associated video call | Nullable if no video call |
| res_id | INTEGER | true | ID of the related resource | Polymorphic link |
| res_model_id | INTEGER | true | ID of the related model | Polymorphic link |
| recurrence_id | INTEGER | true | ID of the recurrence rule | Links to recurrence series |
| create_uid | INTEGER | true | User who created the record | Audit field |
| write_uid | INTEGER | true | User who last updated the record | Audit field |
| name | VARCHAR | false | Subject/Title of the event | |
| location | VARCHAR | true | Physical or virtual location | |
| videocall_location | VARCHAR | true | URL or link for video call | |
| access_token | VARCHAR | true | Security token for external access | Sensitive |
| privacy | VARCHAR | true | Visibility level (e.g., public/private) | |
| show_as | VARCHAR | false | Availability status (e.g., busy/free) | |
| res_model | VARCHAR | true | Name of the related model | Polymorphic link |
| start_date | DATE | true | Start date for all-day events | |
| stop_date | DATE | true | End date for all-day events | |
| description | TEXT | true | Detailed event notes | |
| active | BOOLEAN | true | Soft-delete flag | |
| allday | BOOLEAN | true | Flag for all-day events | |
| recurrency | BOOLEAN | true | Flag if event is recurring | |
| follow_recurrence | BOOLEAN | true | Flag if event follows recurrence | |
| start | TIMESTAMP | false | Start date and time | |
| stop | TIMESTAMP | false | End date and time | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Record last update timestamp | |
| duration | DOUBLE PRECISION | true | Event duration | Units: hours |
| opportunity_id | INTEGER | true | Linked CRM opportunity | Foreign key to CRM |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo user link)
    - `opportunity_id` → `crm_lead.id` (Guess: standard Odoo CRM link)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` column should be masked or excluded from general reporting as it may grant unauthorized access to event details.
- **Timezones:** Timestamps (`start`, `stop`, `create_date`, `write_date`) are typically stored in UTC in Odoo; verify against system configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing audit/historical analysis.
- **Polymorphism:** The `res_id` and `res_model` columns represent a polymorphic relationship; ensure joins are handled correctly by filtering on `res_model` when joining to specific tables.