# mail_wizard_invite_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `mail_wizard_invite_res_partner_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link wizard-based email invitation processes to specific partner records.

## Functional process 
This table supports the "Communication and Collaboration" module, specifically tracking which partners have been included in a mass mailing or invitation wizard session. It acts as a join table to associate specific email invitation events with the target recipients (partners).

## Description
One row represents a single association between a specific email invitation wizard instance and a partner record. This is a raw landing copy of a join table, used to maintain the relationship between communication events and the CRM partner database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_wizard_invite_id | INTEGER | false | Foreign key to the mail invitation wizard | Links to the parent invitation event. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the recipient partner. |

## Keys

- **Primary key (inferred):** The combination of `mail_wizard_invite_id` and `res_partner_id`.
- **Foreign keys (inferred):** 
    - `mail_wizard_invite_id` → `mail_wizard_invite.id` (Inferred from Odoo naming conventions).
    - `res_partner_id` → `res_partner.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes other than the two foreign keys.
- There is no audit timestamp or soft-delete flag present in this table; it represents the current state of the relationship as landed from the source.
- Ensure joins to `res_partner` are handled carefully, as this table may contain references to partners that have been merged or archived in the source system.