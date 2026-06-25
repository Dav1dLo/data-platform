# bus_bus

## Source system
This table originates from an Odoo ERP system. The naming convention `bus_bus` combined with audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date` is characteristic of Odoo's internal messaging and notification bus infrastructure.

## Functional process 
This table supports the real-time notification and messaging system within the ERP. It acts as a message queue or event log for the "bus" mechanism, which facilitates communication between the server and client-side interfaces, such as instant notifications, chat messages, or UI updates.

## Description
One row in this table represents a single message or event broadcasted through the system's notification bus. This is a raw landing table in the staging layer, capturing the state of messages as they are persisted in the database before being consumed or purged by the application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `bus_bus_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| channel | VARCHAR | true | Target channel identifier | The specific bus channel the message is broadcast to. |
| message | VARCHAR | true | The message payload | Contains the event data or notification content. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creation.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `message` column may contain PII or internal system data depending on the nature of the notifications being logged.
- **Timestamps:** Timestamps are stored in the application's configured timezone (typically UTC), but verify against the Odoo system settings.
- **Data Retention:** This table is often subject to high churn; messages are frequently deleted or truncated by the application once processed.
- **Schema:** The table resides in the `public` schema, which is standard for Odoo installations.