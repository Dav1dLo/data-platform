# account_move_send_wizard_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_res_partner_rel` is a standard pattern used by Odoo's ORM to manage many-to-many relationship tables between a wizard (a temporary UI-driven process object) and the `res_partner` (customer/vendor) entity.

## Functional process 
This table supports the "Customer Invoice/Bill Sending" process. It acts as a join table that links specific `account_move_send_wizard` instances to the partners (contacts) associated with those document-sending operations, likely to track which recipients are targeted for a specific batch of invoice communications.

## Description
One row in this table represents a single association between a specific invoice-sending wizard session and a partner record. It is a raw landing copy of a many-to-many relationship table, used to maintain referential integrity between transient wizard states and persistent partner entities during the document distribution workflow.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_send_wizard_id | INTEGER | false | Foreign key to the account move send wizard | Links to the parent wizard session. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the specific contact/partner involved. |

## Keys

- **Primary key (inferred):** The combination of `(account_move_send_wizard_id, res_partner_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_move_send_wizard_id` → `account_move_send_wizard.id`: This column identifies the specific wizard session.
    - `res_partner_id` → `res_partner.id`: This column identifies the partner record involved in the wizard.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present in this table; it is strictly structural.
- As a staging table for a wizard process, rows here are likely transient and may be purged by the source system once the wizard session is completed or closed.