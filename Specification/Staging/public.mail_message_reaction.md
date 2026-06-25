# mail_message_reaction

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `mail_message_reaction` and the presence of `partner_id` and `guest_id` columns, which are standard identifiers for Odoo's internal messaging and chatter framework.

## Functional process 
This table supports the internal communication and collaboration module within the ERP. It tracks user-generated reactions (such as emojis or status indicators) attached to specific messages within the system's chatter or discussion threads.

## Description
One row represents a single reaction instance applied to a specific message by either a registered partner or a guest user. This is a raw landed staging table, serving as a direct reflection of the source system's reaction event log.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mail_message_reaction_id_seq`. |
| message_id | INTEGER | false | Foreign key to the parent message | Links to the message being reacted to. |
| partner_id | INTEGER | true | Foreign key to the internal partner | Represents a registered system user. |
| guest_id | INTEGER | true | Foreign key to the guest user | Represents an external or unauthenticated user. |
| content | VARCHAR | false | The reaction content | Typically contains the emoji or reaction string. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id`: Links the reaction to the specific message record.
    - `partner_id` → `res_partner.id`: Links the reaction to the registered user who performed the action.
    - `guest_id` → `mail_guest.id`: Links the reaction to the guest session who performed the action.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table contains mixed authorship: a reaction will typically have either a `partner_id` or a `guest_id` populated, but rarely both.
- The `content` column is a raw string; downstream consumers should expect emoji characters or short text codes.
- There is no explicit timestamp column in this table; temporal analysis of reactions is not possible without joining to the parent message or audit logs.
- This is a staging table; assume no data cleaning or deduplication has been performed.