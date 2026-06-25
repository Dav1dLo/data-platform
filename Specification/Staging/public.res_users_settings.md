# res_users_settings

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_users_settings`, the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of a sequence-based default for the primary key.

## Functional process 
This table supports the user preference and configuration management process within the Odoo Discuss and Calendar modules. It tracks individual user settings for communication features, such as push-to-talk configurations, notification preferences, and UI state for the sidebar, as well as default privacy settings for calendar events.

## Description
One row in this table represents the unique set of application-level preferences for a single user. It serves as a raw landed copy of the user settings entity, capturing the current state of UI and communication configurations at the grain of one row per user.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| user_id | INTEGER | false | Foreign key to the user | Links to the system user account. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC. |
| voice_active_duration | INTEGER | true | Voice activity duration | Likely measured in milliseconds or seconds. |
| push_to_talk_key | VARCHAR | true | Push-to-talk shortcut key | The keyboard key assigned for PTT. |
| channel_notifications | VARCHAR | true | Notification preference | Configuration string for channel alerts. |
| is_discuss_sidebar_category_channel_open | BOOLEAN | true | Sidebar channel state | UI state for the channel category. |
| is_discuss_sidebar_category_chat_open | BOOLEAN | true | Sidebar chat state | UI state for the chat category. |
| use_push_to_talk | BOOLEAN | true | PTT enabled flag | Whether push-to-talk is active. |
| mute_until_dt | TIMESTAMP | true | Mute expiration | Timestamp until which notifications are muted. |
| calendar_default_privacy | VARCHAR | false | Default privacy level | Default visibility for new calendar events. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id`: This is a standard Odoo pattern linking settings to the core user record.
    - `create_uid` → `res_users.id`: Links to the user who performed the creation.
    - `write_uid` → `res_users.id`: Links to the user who performed the last update.
- **Natural keys (inferred):** 
    - `user_id`: In Odoo, a user typically has only one settings record, making `user_id` the business-level unique identifier.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`, `mute_until_dt`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains UI state and user preferences; it does not contain PII or sensitive financial data, though it may reveal user activity patterns.
- The table does not implement soft deletes; updates are performed in-place via the `write_date` and `write_uid` columns.
- `voice_active_duration` unit is not explicitly defined in the schema; verify against application logic if precise timing is required.