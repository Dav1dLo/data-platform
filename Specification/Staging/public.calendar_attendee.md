# calendar_attendee

## Source system
This table likely originates from an Odoo ERP or a similar modular business management system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of sequence-based primary keys (`nextval`), is highly characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the scheduling and calendar management process, specifically tracking the participation status of partners (contacts/users) in scheduled events. It manages the link between events and attendees, tracking their RSVP status (`state`) and time-slot availability.

## Description
One row in this table represents a single attendee's association with a specific calendar event. It acts as a raw landed staging record capturing the participant's metadata, their response status, and system audit timestamps. The grain is one row per attendee per event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `calendar_attendee_id_seq`. |
| event_id | INTEGER | false | Foreign key to the event | Links to the parent calendar event. |
| partner_id | INTEGER | false | Foreign key to the partner | Links to the contact/user record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| common_name | VARCHAR | true | Display name | The name of the attendee as shown in the event. |
| access_token | VARCHAR | true | Security token | Used for external calendar invitation links. |
| state | VARCHAR | true | RSVP status | e.g., 'needsAction', 'accepted', 'declined'. |
| availability | VARCHAR | true | Time availability | Indicates if the attendee is 'busy' or 'free'. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `event_id` → `calendar_event.id` (Inferred from standard Odoo naming conventions).
    - `partner_id` → `res_partner.id` (Inferred from standard Odoo naming conventions).
- **Natural keys (inferred):** 
    - The combination of `event_id` and `partner_id` likely forms the business-level uniqueness constraint for an attendee in an event.

## Caveats for downstream consumers

- **Sensitive Data:** `access_token` should be treated as a secret; do not expose this in reporting layers.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by business logic.
- **Data Quality:** `common_name` may be redundant if `partner_id` is joined to the master partner table; verify if this field is denormalized or a snapshot of the name at the time of invitation.