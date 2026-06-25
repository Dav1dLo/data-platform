# res_groups_users_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_groups_users_rel` is a standard pattern used by Odoo to represent the many-to-many relationship between security groups (`res_groups`) and system users (`res_users`).

## Functional process 
This table supports the Identity and Access Management (IAM) process within the ERP. It maps users to their assigned security groups, which in turn dictate the permissions, access rights, and menu visibility for those users across the application.

## Description
One row in this table represents a single assignment of a user to a specific security group. It is a raw landing of a join table, serving as the bridge between user entities and group entities in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| gid | INTEGER | false | Group ID | Foreign key referencing the security group. |
| uid | INTEGER | false | User ID | Foreign key referencing the system user. |

## Keys

- **Primary key (inferred):** The combination of (`gid`, `uid`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `gid` → `res_groups.id`: This column links to the security group definition table.
    - `uid` → `res_users.id`: This column links to the user account definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of group memberships as captured during the last extraction.
- Ensure joins to `res_groups` and `res_users` are performed using inner joins if you only require active, valid associations.