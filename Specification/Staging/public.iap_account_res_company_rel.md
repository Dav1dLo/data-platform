# iap_account_res_company_rel

## Source system
This table originates from an Odoo ERP environment. The naming convention `iap_account_res_company_rel` follows the standard Odoo pattern for a many-to-many join table linking an In-App Purchase (IAP) account to a specific company record within the `res_company` master data table.

## Functional process 
This table supports the multi-company configuration for In-App Purchase services. It manages the relationship between IAP accounts and the companies authorized to utilize them, ensuring that service credits or subscriptions are correctly scoped to the appropriate legal entity within the ERP.

## Description
One row in this table represents a single association between an IAP account and a company. It acts as a link table at the grain of a unique pairing, facilitating many-to-many relationships between the two entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| iap_account_id | INTEGER | false | Foreign key to the IAP account | References the primary key of the IAP account table. |
| res_company_id | INTEGER | false | Foreign key to the company | References the primary key of the `res_company` table. |

## Keys

- **Primary key (inferred):** The composite key `(iap_account_id, res_company_id)`.
- **Foreign keys (inferred):** 
    - `iap_account_id` → `iap_account.id`: Links to the specific IAP account configuration.
    - `res_company_id` → `res_company.id`: Links to the specific company entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure joins to `res_company` and `iap_account` are performed using inner joins if you only require active, valid relationships.