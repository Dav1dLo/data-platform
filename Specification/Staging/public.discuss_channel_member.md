# discuss_channel_member

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (e.g., `partner_id`, `create_uid`, `write_date`) and the use of standard Odoo sequence generators for the primary key.

## Functional process 
This table supports the internal messaging and collaboration module within the ERP. It manages the membership state of users (partners) or guests within specific communication channels, tracking read receipts, notification preferences, and UI states like channel folding or muting.

## Description
One row in this table represents a single membership association between a user/guest and a specific communication channel. It acts as a raw landing copy of the membership state, capturing metadata such as the last seen message, notification settings, and UI-specific preferences for that user within that channel.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `discuss_channel_member_id_seq` |
| partner_id | INTEGER | true | Foreign key to the partner/user | Identifies the registered user |
| guest_id | INTEGER | true | Foreign key to the guest user | Identifies an unauthenticated guest |
| channel_id | INTEGER | false | Foreign key to the channel | The communication channel identifier |
| fetched_message_id | INTEGER | true | Last fetched message ID | Used for message synchronization |
| seen_message_id | INTEGER | true | Last read message ID | Used for read receipt tracking |
| new_message_separator | INTEGER | false | Message ID separator | Marks the boundary for new messages |
| rtc_inviting_session_id | INTEGER | true | RTC session ID | Links to real-time communication sessions |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates |
| custom_channel_name | VARCHAR | true | User-defined channel alias | UI override for the channel name |
| fold_state | VARCHAR | true | UI fold status | Tracks if the channel is collapsed |
| custom_notifications | VARCHAR | true | Notification settings | JSON or string-based preference config |
| mute_until_dt | TIMESTAMP | true | Mute expiration timestamp | Time until which notifications are muted |
| unpin_dt | TIMESTAMP | true | Unpin timestamp | Time when the channel was unpinned |
| last_interest_dt | TIMESTAMP | true | Last interaction timestamp | Tracks user activity within the channel |
| last_seen_dt | TIMESTAMP | true | Last seen timestamp | Timestamp of the last read action |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: standard Odoo partner reference)
    - `channel_id` → `discuss_channel.id` (Guess: standard Odoo channel reference)
- **Natural keys (inferred):** 
    - `(partner_id, channel_id)` or `(guest_id, channel_id)` (The combination of user/guest and channel uniquely defines the membership)

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`, etc.) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The table contains both `partner_id` and `guest_id`; queries should handle the logic where one or both may be null depending on the user type.
- This is a staging table; it may contain frequent updates to `last_seen_dt` and `write_date` as users interact with the messaging interface.
- No explicit soft-delete flag is present; assume standard Odoo behavior where records are either hard-deleted or maintained indefinitely.