# mail_compose_message_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific column names `wizard_id` and `partner_id` is characteristic of Odoo's automated many-to-many relationship tables used to link message composition wizards to specific business partners (contacts).

## Functional process 
This table supports the communication and notification module within the ERP. It tracks the association between a message composition event (the wizard) and the recipients or involved partners, facilitating the routing of emails or internal notifications to the correct contact entities.

## Description
One row represents a single association between a specific message composition wizard instance and a partner record. It serves as a raw landing copy of the join table used to manage many-to-many relationships in the staging layer, ensuring that message recipients are correctly mapped to the composition process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the mail_compose_message wizard | Represents the specific message composition session. |
| partner_id | INTEGER | false | Foreign key to the res_partner table | Represents the contact or partner involved in the message. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`wizard_id`, `partner_id`).
- **Foreign keys (inferred):** 
    - `wizard_id` → `mail_compose_message.id`: Links to the parent message composition record.
    - `partner_id` → `res_partner.id`: Links to the contact record.
- **Natural keys (inferred):** The combination of (`wizard_id`, `partner_id`) acts as the natural key for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table is truncated/reloaded or managed by the application's ORM layer.
- Ensure joins to `res_partner` are handled carefully as this table may contain references to partners that have been archived or deleted in the source system.