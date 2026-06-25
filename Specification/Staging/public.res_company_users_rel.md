# res_company_users_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_company_users_rel` is a standard pattern used by Odoo to manage many-to-many relationship tables (often referred to as "relation tables" or "junction tables") between the `res_company` and `res_users` entities.

## Functional process 
This table supports multi-company access management within the ERP. It defines the authorization mapping that dictates which users are permitted to access or operate within specific company environments, facilitating the multi-tenant architecture of the platform.

## Description
One row in this table represents a single association between a user and a company, granting the user access to that company's data. As a staging table, it provides a raw, un-transformed copy of the junction data directly from the source database, intended for use in building downstream access control models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| cid | INTEGER | false | Company ID | Foreign key referencing the company entity. |
| user_id | INTEGER | false | User ID | Foreign key referencing the user entity. |

## Keys

- **Primary key (inferred):** The combination of `(cid, user_id)` is the inferred composite primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `cid` → `res_company.id`: This column links to the company definition table.
    - `user_id` → `res_users.id`: This column links to the user account definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between companies and users.
- There are no audit timestamps (e.g., `created_at` or `updated_at`) present in this table, so incremental loading based on time is not possible.
- The table contains no sensitive PII directly, but it defines the security boundary for user access to company data.
- Ensure joins to `res_company` and `res_users` are handled as inner joins if you only require active associations.