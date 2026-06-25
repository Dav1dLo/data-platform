# calendar_event_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `res_partner` (Odoo's core entity for contacts/customers) and `calendar_event` is a signature pattern for Odoo's many-to-many relationship tables.

## Functional process 
This table supports the scheduling and meeting management process. It acts as a junction table to link calendar events to the specific partners (attendees) invited to or participating in those events.

## Description
One row in this table represents a single association between a calendar event and a partner. It is a raw landing copy of a many-to-many join table, used to resolve the relationship between meeting records and contact records in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Represents the attendee or contact involved in the event. |
| calendar_event_id | INTEGER | false | Foreign key to the calendar event record | Represents the specific meeting or appointment. |

## Keys

- **Primary key (inferred):** The composite key of (`calendar_event_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `res_partner_id` → `res_partner.id`: Links to the contact master data.
    - `calendar_event_id` → `calendar_event.id`: Links to the event master data.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes (like status or RSVP response) other than the relationship itself.
- There are no timestamps or audit columns present in this table; incremental loading logic must rely on the upstream source system's change tracking or full-table replacement.
- As a staging table, this may contain orphaned records if the parent `calendar_event` or `res_partner` records were deleted in the source system without cascading deletes.