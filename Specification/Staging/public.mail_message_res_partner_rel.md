# mail_message_res_partner_rel

## Source system
This table originates from Odoo ERP, as indicated by the naming convention `mail_message_res_partner_rel`, which is the standard pattern for a many-to-many join table linking communication messages to business partners (contacts) in the Odoo framework.

## Functional process 
This table supports the communication and notification tracking process. It maps which business partners are recipients or participants in specific system messages, facilitating the "chatter" or notification history features within the ERP.

## Description
One row in this table represents a single association between a specific mail message and a business partner. It is a raw landing copy of a join table used to resolve the many-to-many relationship between the `mail_message` and `res_partner` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_message_id | INTEGER | false | Foreign key to the mail message entity | Links to the primary message record. |
| res_partner_id | INTEGER | false | Foreign key to the business partner entity | Links to the contact record. |

## Keys

- **Primary key (inferred):** The composite key `(mail_message_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: Links to the message content.
    - `res_partner_id` → `res_partner.id`: Links to the partner/contact record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this represents the current state of associations as captured during the last ingestion.
- Ensure joins are performed on both columns to maintain the integrity of the many-to-many relationship.