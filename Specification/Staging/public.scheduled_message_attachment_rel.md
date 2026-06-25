# scheduled_message_attachment_rel

## Source system
The source system is unknown — insufficient evidence. The table name follows a standard junction table naming convention common in relational databases (e.g., PostgreSQL, MySQL) used to resolve many-to-many relationships, but it does not map to a specific known SaaS platform or ERP system.

## Functional process 
This table supports a messaging or notification system, specifically managing the association between scheduled messages and their corresponding file or media attachments. It facilitates the "Message-to-Attachment" link, ensuring that when a message is dispatched, the system can retrieve the correct associated assets.

## Description
One row in this table represents a single association between a specific scheduled message and an attachment. It acts as a link table (associative entity) at the grain of one row per message-attachment pair. As a staging table, it serves as a raw landed copy of the relationship mapping from the source operational database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| scheduled_message_id | INTEGER | false | Foreign key to the scheduled message entity | Represents the parent message. |
| attachment_id | INTEGER | false | Foreign key to the attachment entity | Represents the associated file or media. |

## Keys

- **Primary key (inferred):** The composite of (`scheduled_message_id`, `attachment_id`).
- **Foreign keys (inferred):** 
    - `scheduled_message_id` → `scheduled_messages.id` (guessed based on naming convention).
    - `attachment_id` → `attachments.id` (guessed based on naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the creation order or lifecycle of these relationships from this table alone.
- Ensure that joins to parent tables handle potential orphaned records if referential integrity is not strictly enforced in the source system.