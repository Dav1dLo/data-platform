# iap_account_res_users_rel

## Source system
This table likely originates from an Odoo ERP instance. The naming convention `iap_account_res_users_rel` follows the standard Odoo pattern for a many-to-many join table linking the In-App Purchase (IAP) account module to the core `res.users` system table.

## Functional process 
This table supports the user-to-account authorization and entitlement process within the IAP framework. It manages the mapping between internal system users and their associated IAP accounts, which are required for consuming external services or credits within the ERP environment.

## Description
One row in this table represents a single association between an IAP account and a system user. It acts as a bridge table to resolve a many-to-many relationship, ensuring that users can be linked to specific IAP accounts for service authentication. This is a raw landed copy of the join table from the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| iap_account_id | INTEGER | false | Foreign key to the IAP account | Represents the unique identifier for the IAP account entity. |
| res_users_id | INTEGER | false | Foreign key to the system user | Represents the unique identifier for the user in the `res_users` table. |

## Keys

- **Primary key (inferred):** The composite key `(iap_account_id, res_users_id)`.
- **Foreign keys (inferred):** 
    - `iap_account_id` → `iap_account.id`: Links to the IAP account definition.
    - `res_users_id` → `res_users.id`: Links to the core system user record.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure that joins to `res_users` or `iap_account` handle potential orphans if the upstream source systems are not perfectly synchronized.