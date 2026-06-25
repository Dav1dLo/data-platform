# discuss_channel_rtc_session

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`public.discuss_channel_rtc_session_id_seq`), the presence of `create_uid` and `write_uid` audit columns, and the `create_date`/`write_date` timestamp pattern typical of Odoo's ORM layer.

## Functional process 
This table supports the real-time communication (RTC) module within the Odoo Discuss application. It tracks the active state of individual participants within a communication channel, specifically monitoring their media settings (camera, screen sharing, audio) during a live session.

## Description
One row in this table represents the current state of a single participant's connection within a specific RTC channel. This is a raw staging table containing the latest state snapshots for active or recent communication sessions, used to track user-specific settings like muting or screen sharing status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `discuss_channel_rtc_session_id_seq` |
| channel_member_id | INTEGER | false | Foreign key to the channel member | Identifies the participant |
| channel_id | INTEGER | true | Foreign key to the communication channel | Links session to a specific room/channel |
| create_uid | INTEGER | true | User ID who created the record | References `res.users` |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users` |
| is_screen_sharing_on | BOOLEAN | true | Screen sharing status | True if user is sharing screen |
| is_camera_on | BOOLEAN | true | Camera status | True if user's camera is active |
| is_muted | BOOLEAN | true | Audio mute status | True if user is muted |
| is_deaf | BOOLEAN | true | Audio deaf status | True if user cannot hear audio |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `channel_member_id` → `discuss_channel_member.id` (Guess: links to the specific member record in the channel).
    - `channel_id` → `discuss_channel.id` (Guess: links to the parent communication channel).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo audit trail linking to the users table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Volatility:** This table represents state; expect frequent updates to the boolean flags (`is_muted`, `is_camera_on`, etc.) as users interact with the RTC interface.
- **Soft Deletes:** There is no explicit `active` or `deleted` flag; however, Odoo tables often rely on application-level logic to prune or archive session records.
- **Nullability:** Many fields are nullable, reflecting that session states may not be fully initialized or may be cleared upon session termination.