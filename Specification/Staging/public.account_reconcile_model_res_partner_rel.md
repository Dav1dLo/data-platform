# account_reconcile_model_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific entity names `account_reconcile_model` and `res_partner` is characteristic of Odoo's automated many-to-many relationship tables, which link reconciliation models to specific business partners.

## Functional process 
This table supports the financial reconciliation process by defining which business partners (customers or vendors) are eligible for or restricted to specific automated reconciliation models. It acts as a filter or association layer to ensure that reconciliation rules are applied only to the relevant partner accounts during the bank statement or invoice matching workflow.

## Description
One row represents a single association between a specific reconciliation model and a business partner. It is a raw landing of a many-to-many join table, used to resolve the relationship between accounting automation rules and partner entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model | Links to the primary reconciliation rule definition. |
| res_partner_id | INTEGER | false | Foreign key to the business partner | Links to the partner (customer/vendor) entity. |

## Keys

- **Primary key (inferred):** The composite of (`account_reconcile_model_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `account_reconcile_model.id`: This column references the parent reconciliation model definition.
    - `res_partner_id` → `res_partner.id`: This column references the partner entity record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; this table represents the current state of associations as extracted from the source.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.