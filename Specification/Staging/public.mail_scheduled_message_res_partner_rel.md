# mail_scheduled_message_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `mail_scheduled_message` and `res_partner` is characteristic of Odoo's automated many-to-many relationship tables, which link communication objects to business partners (contacts).

## Functional process 
This table supports the communication and notification module within the ERP. It manages the association between scheduled email or message tasks and the specific partners (customers, vendors, or employees) who are designated as recipients or participants for those messages.

## Description
One row in this table represents a single link between a scheduled mail message and a partner entity. It is a junction table used to resolve a many-to-many relationship, ensuring that a single message can be associated with multiple partners and vice versa. As a staging table, it provides a raw, normalized view of these associations as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_scheduled_message_id | INTEGER | false | Foreign key to the scheduled message entity | Links to the primary message record. |
| res_partner_id | INTEGER | false | Foreign key to the partner entity | Links to the specific contact or user record. |

## Keys

- **Primary key (inferred):** The combination of `(mail_scheduled_message_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `mail_scheduled_message_id` → `mail_scheduled_message.id`: This column references the parent message record.
    - `res_partner_id` → `res_partner.id`: This column references the parent partner record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table represents the current state of associations as captured during the last ingestion.
- Ensure that joins to the target tables handle potential orphans if the source system's referential integrity is not strictly enforced.