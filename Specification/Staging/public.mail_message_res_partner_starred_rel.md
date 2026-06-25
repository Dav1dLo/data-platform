# mail_message_res_partner_starred_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `mail_message` and `res_partner` is characteristic of Odoo's many-to-many relationship tables used to track message-specific metadata.

## Functional process 
This table supports the internal communication and notification system within the ERP. It specifically manages the "starred" or "flagged" status of messages for individual partners (users or contacts), allowing the system to track which specific messages have been marked as important by which specific partners.

## Description
One row in this table represents a single "starred" association between a specific message and a specific partner. It is a raw landing of a join table, serving as a link entity to resolve the many-to-many relationship between messages and partners in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_message_id | INTEGER | false | Foreign key to the mail_message table | Represents the unique identifier of the message being starred. |
| res_partner_id | INTEGER | false | Foreign key to the res_partner table | Represents the unique identifier of the partner who starred the message. |

## Keys

- **Primary key (inferred):** The composite key of (`mail_message_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: Links to the core message entity.
    - `res_partner_id` → `res_partner.id`: Links to the partner/user entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes other than the relationship itself.
- The presence of a row implies a "starred" status; the absence of a row implies the message is not starred by that partner.
- No audit timestamps (e.g., `created_at`) are present in this table, so the exact time a message was starred cannot be determined from this source.