# message_attachment_rel

## Source system
Unknown — insufficient evidence. The table name suggests a junction table linking messages to attachments, which is common in custom-built messaging or ticketing systems, but there are no specific vendor-identifying prefixes or naming conventions to confirm a source.

## Functional process 
This table supports a many-to-many relationship management process within a communication or document-sharing module. It enables the association of multiple file attachments with a single message, or conversely, the association of a single attachment with multiple messages.

## Description
One row in this table represents a single link between a specific message and a specific attachment. It serves as a raw, normalized junction table in the staging layer, facilitating the resolution of many-to-many relationships between message entities and attachment entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| message_id | INTEGER | false | Foreign key referencing the message entity. | None. |
| attachment_id | INTEGER | false | Foreign key referencing the attachment entity. | None. |

## Keys

- **Primary key (inferred):** The composite key `(message_id, attachment_id)` is the inferred primary key as it represents the unique relationship between the two entities.
- **Foreign keys (inferred):** 
    - `message_id` → `message.id` (guess: standard naming convention for linking to a parent message table).
    - `attachment_id` → `attachment.id` (guess: standard naming convention for linking to a parent attachment table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; ensure joins are performed on both columns to avoid Cartesian products.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of relationships as captured during the last ingestion.
- The table contains no PII, but ensure that the parent tables (`message` and `attachment`) are checked for sensitive content before joining.