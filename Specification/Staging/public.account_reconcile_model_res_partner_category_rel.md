# account_reconcile_model_res_partner_category_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `account_reconcile_model_res_partner_category_rel` follows the standard Odoo pattern for a many-to-many join table linking reconciliation models to partner categories.

## Functional process 
This table supports the automated accounting reconciliation process. It defines the relationship between specific bank reconciliation models and partner categories, allowing the system to apply specific matching rules or templates based on the category of the business partner involved in a transaction.

## Description
One row in this table represents a single association between a reconciliation model and a partner category. It serves as a raw landing of the many-to-many join table, enabling the system to filter or prioritize reconciliation logic based on partner classification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model | Links to the primary reconciliation configuration. |
| res_partner_category_id | INTEGER | false | Foreign key to the partner category | Links to the classification of the business partner. |

## Keys

- **Primary key (inferred):** The composite key `(account_reconcile_model_id, res_partner_category_id)`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `account_reconcile_model.id`: References the parent reconciliation model definition.
    - `res_partner_category_id` → `res_partner_category.id`: References the category definition for business partners.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table.
- Ensure joins to parent tables handle potential missing records if the source system performs hard deletes on parent entities.