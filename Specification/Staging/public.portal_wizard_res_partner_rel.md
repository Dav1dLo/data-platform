# portal_wizard_res_partner_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `res_partner` is the standard internal identifier for the "Partner" (customer/vendor/contact) model in Odoo, and `portal_wizard` indicates a specific functional module used for managing portal access rights.

## Functional process 
This table supports the "Portal Access Management" process. It acts as a join table to associate specific portal wizard instances with the business partners (users or contacts) who have been granted or are being processed for portal access.

## Description
One row in this table represents a single association between a portal wizard record and a partner record. It is a raw landing copy of a many-to-many relationship table, used to resolve the link between portal configuration wizards and the entities they affect.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| portal_wizard_id | INTEGER | false | Foreign key to the portal wizard instance | Links to the parent wizard configuration. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the specific contact or user. |

## Keys

- **Primary key (inferred):** The combination of `(portal_wizard_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `portal_wizard_id` → `portal_wizard.id` (Guess: links to the wizard definition table).
    - `res_partner_id` → `res_partner.id` (Guess: links to the core partner/contact table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure joins to `res_partner` and `portal_wizard` are handled as inner joins if you only require validated associations.