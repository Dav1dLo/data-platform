# calendar_popover_delete_wizard

## Source system
This table originates from an Odoo ERP environment. The naming convention (using `_wizard` and `_uid` suffixes) and the specific sequence pattern (`nextval('"public".calendar_popover_delete_wizard_id_seq'::regclass)`) are characteristic of Odoo's transient model architecture, which manages temporary UI state for user-driven actions.

## Functional process 
This table supports the "Calendar Event Deletion" workflow. It acts as a transient staging area for the wizard interface that prompts users to confirm the deletion of calendar events, specifically handling the logic for whether to delete a single occurrence or an entire series of events.

## Description
One row in this table represents a single instance of a user interacting with the calendar deletion wizard. It captures the state of the deletion request, including the target record ID and the user performing the action, before the final deletion is committed to the core calendar tables. This is a raw landing table in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a standard Odoo sequence. |
| record | INTEGER | true | Target record identifier | References the specific calendar event being deleted. |
| create_uid | INTEGER | true | Creator user ID | The user who initiated the wizard session. |
| write_uid | INTEGER | true | Last modifier user ID | The user who last updated the wizard state. |
| delete | VARCHAR | true | Deletion scope/mode | Likely stores a flag or string indicating 'one' vs 'all' events. |
| create_date | TIMESTAMP | true | Creation timestamp | When the wizard session was opened. |
| write_date | TIMESTAMP | true | Last update timestamp | When the wizard session was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `record` → `calendar_event.id` (Guess: links to the event being deleted).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is likely transient; data may be purged or truncated by the application periodically.
- Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo, but verify against the application server configuration.
- The `delete` column is a `VARCHAR` and may contain non-standardized values depending on the specific Odoo version's implementation of the wizard.
- No PII is explicitly identified, but `create_uid` and `write_uid` link to user identities.