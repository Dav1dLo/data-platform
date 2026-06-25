# discuss_channel

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports the internal communication and collaboration module (Discuss). It manages the configuration and state of communication channels, including direct messages, group chats, and public channels, tracking their hierarchy, access permissions, and integration with external SFU (Selective Forwarding Unit) servers for video/audio conferencing.

## Description
One row represents a single communication channel or chat room within the platform. It serves as a raw landed copy of the channel configuration, capturing metadata such as channel type, display settings, and activity status. The grain is one row per unique channel identifier.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| parent_channel_id | INTEGER | true | Self-referencing parent channel | Used for nested or sub-channel structures. |
| from_message_id | INTEGER | true | Originating message ID | Links the channel to a specific message context. |
| group_public_id | INTEGER | true | Public group identifier | Links to a public group entity if applicable. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| name | VARCHAR | false | Channel display name | Human-readable name of the channel. |
| channel_type | VARCHAR | false | Type of channel | e.g., 'chat', 'channel', 'livechat'. |
| default_display_mode | VARCHAR | true | UI display preference | Defines how the channel appears in the interface. |
| sfu_channel_uuid | VARCHAR | true | SFU channel identifier | Unique ID for video/audio conferencing integration. |
| sfu_server_url | VARCHAR | true | SFU server endpoint | URL for the media server. |
| uuid | VARCHAR(50) | true | External unique identifier | Often used for API or cross-system references. |
| description | TEXT | true | Channel description | Long-form text describing the channel purpose. |
| active | BOOLEAN | true | Soft-delete flag | If false, the channel is archived/inactive. |
| allow_public_upload | BOOLEAN | true | File upload permission | Flag for public access to upload files. |
| last_interest_dt | TIMESTAMP | true | Last activity timestamp | Used to track channel relevance. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_channel_id` → `public.discuss_channel.id` (Self-referencing hierarchy).
    - `create_uid` → `public.res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `public.res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** 
    - `uuid` (Likely used for external system synchronization).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column should be filtered (`WHERE active = TRUE`) to exclude archived channels.
- **Timestamps:** All `_date` and `_dt` columns are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **PII:** The `name` and `description` fields may contain sensitive project or user information; handle with appropriate access controls.
- **Denormalization:** This is a raw staging table; expect potential inconsistencies in `channel_type` values if the source system configuration has evolved.