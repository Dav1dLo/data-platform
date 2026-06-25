# mail_followers_mail_message_subtype_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `table_a_table_b_rel` is the standard pattern used by the Odoo ORM to manage many-to-many relationship tables in its underlying PostgreSQL database.

## Functional process 
This table supports the notification and subscription management process within the Odoo communication module. It defines which specific message subtypes (e.g., "Discussions", "Note", "Comment") a follower is subscribed to, allowing the system to filter which notifications are sent to specific users or partners.

## Description
One row in this table represents a single association between a follower record and a message subtype, establishing a many-to-many relationship. As a staging table, it serves as a raw, normalized link entity used to reconstruct subscription preferences for downstream reporting or notification analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_followers_id | INTEGER | false | Foreign key to the mail_followers table | Represents the subscriber entity. |
| mail_message_subtype_id | INTEGER | false | Foreign key to the mail_message_subtype table | Represents the specific type of message being followed. |

## Keys

- **Primary key (inferred):** The composite key of (`mail_followers_id`, `mail_message_subtype_id`).
- **Foreign keys (inferred):** 
    - `mail_followers_id` → `mail_followers.id`: Links to the follower record defining the subscription.
    - `mail_message_subtype_id` → `mail_message_subtype.id`: Links to the definition of the message subtype.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only foreign keys.
- There is no surrogate primary key column; queries should join on the composite pair of IDs.
- As a staging table, it reflects the raw state of the Odoo database; ensure that downstream joins account for potential orphaned records if referential integrity is not strictly enforced at the source.