# res_groups_website_menu_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_groups_website_menu_rel` is characteristic of Odoo's internal many-to-many relationship tables, which link security groups (`res_groups`) to website menu items (`website_menu`).

## Functional process 
This table supports the Access Control List (ACL) management for website navigation. It defines which user security groups are authorized to view specific menu items on the website, ensuring that menu visibility is restricted based on user permissions.

## Description
Each row represents a single association between a security group and a website menu item, effectively granting the group access to that menu. This is a raw landing table in the staging layer, representing a direct dump of the join table used by the Odoo application to enforce menu-level security.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| website_menu_id | INTEGER | false | Foreign key to the website menu definition | Links to the menu item being restricted. |
| res_groups_id | INTEGER | false | Foreign key to the security group definition | Links to the group authorized to see the menu. |

## Keys

- **Primary key (inferred):** The combination of `(website_menu_id, res_groups_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `website_menu_id` → `website_menu.id`: This column references the primary identifier of the website menu table.
    - `res_groups_id` → `res_groups.id`: This column references the primary identifier of the security groups table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; this represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins to `res_groups` and `website_menu` are handled as inner joins if you only require active, valid associations.