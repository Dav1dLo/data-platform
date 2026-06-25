# bus_presence

## Source system
The source system is likely an internal application or service managing real-time user session states, such as a chat platform, collaboration tool, or a web-based dashboard. The naming convention `bus_presence` and the presence of polling-related timestamps suggest a system tracking active user connectivity or "online/offline" status.

## Functional process 
This table supports a user presence or session management process. It tracks the current connectivity state of users and guests within the application, likely used to power "who is online" features or to manage session timeouts and heartbeat signals.

## Description
One row in this table represents the current presence state for a specific user or guest. It acts as a raw landing copy of the application's session state, capturing the most recent poll and presence activity for each entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence `bus_presence_id_seq`. |
| user_id | INTEGER | true | Identifier for the registered user | Nullable if the presence record belongs to a guest. |
| status | VARCHAR | true | Current presence status | Likely values include 'online', 'away', 'offline'. |
| last_poll | TIMESTAMP | true | Timestamp of the last heartbeat signal | Used to determine if a session is still active. |
| last_presence | TIMESTAMP | true | Timestamp of the last state change | Represents the last time the user's status was updated. |
| guest_id | INTEGER | true | Identifier for an unauthenticated guest | Nullable if the record belongs to a registered user. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `users.id` (guess: standard user reference).
    - `guest_id` → `guests.id` (guess: standard guest reference).
- **Natural keys (inferred):** 
    - `user_id` (when present)
    - `guest_id` (when present)

## Caveats for downstream consumers

- The `user_id` and `guest_id` columns are mutually exclusive in practice; ensure queries handle cases where both might be null.
- Timestamps are assumed to be in UTC, but this should be verified against the application's configuration.
- This table represents the current state; there is no indication of historical tracking (no SCD type 2 logic).
- Sensitive data: `user_id` and `guest_id` are identifiers that may need to be treated as PII depending on the downstream system's security requirements.