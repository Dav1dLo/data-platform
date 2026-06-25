# account_group

## Source system
This table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`), the use of `JSONB` for localized names, and the specific sequence pattern `nextval('"public".account_group_id_seq'::regclass)` are characteristic of Odoo's PostgreSQL database schema.

## Functional process 
This table supports the financial accounting structure, specifically the definition of account groups used for hierarchical reporting and chart of accounts organization. It manages the grouping logic for ledger accounts, likely used in financial statement generation and balance sheet categorization.

## Description
One row in this table represents a single account group within the organizational hierarchy. It acts as a raw landed staging entity, capturing the structural definition and metadata for grouping financial accounts. The grain is one row per account group definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_group_id_seq` sequence. |
| parent_id | INTEGER | true | Self-referencing parent group ID | Defines the hierarchy tree. |
| company_id | INTEGER | false | Owning company ID | Links the group to a specific legal entity. |
| create_uid | INTEGER | true | User ID who created the record | References a user in the system. |
| write_uid | INTEGER | true | User ID who last modified the record | References a user in the system. |
| code_prefix_start | VARCHAR | true | Starting range for account codes | Used to filter accounts belonging to this group. |
| code_prefix_end | VARCHAR | true | Ending range for account codes | Used to filter accounts belonging to this group. |
| name | JSONB | false | Group name | Likely contains multi-language translations. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `public.account_group.id`: Establishes the parent-child relationship for the hierarchy.
    - `company_id` → `public.res_company.id` (guess): Links the group to a company entity.
    - `create_uid` / `write_uid` → `public.res_users.id` (guess): Links to the user who performed the action.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; you will need to use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract readable text.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- This table represents a hierarchical structure; recursive CTEs are required to traverse the full tree if `parent_id` is utilized.
- No explicit soft-delete flag is present; assume records are hard-deleted if they disappear from the source.