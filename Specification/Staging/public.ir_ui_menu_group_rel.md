# ir_ui_menu_group_rel

## Source system
The table likely originates from an Odoo ERP system, as indicated by the `ir_ui_menu` naming convention, which is standard for Odoo's internal user interface menu structures.

## Functional process 
This table supports the user interface access control process by managing the many-to-many relationship between menu items and user groups. It determines which groups have visibility or access to specific menu items within the application's navigation structure.

## Description
One row represents a single association between a specific menu item and a user group. It serves as a raw landing copy of the join table used to enforce menu-level permissions in the application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| menu_id | INTEGER | false | Foreign key to the menu definition | Links to the primary menu table. |
| gid | INTEGER | false | Foreign key to the user group definition | Represents the group ID authorized to access the menu. |

## Keys

- **Primary key (inferred):** The combination of (`menu_id`, `gid`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `menu_id` → `ir_ui_menu.id` (Guess: standard Odoo naming pattern for menu relations).
    - `gid` → `res_groups.id` (Guess: standard Odoo naming pattern for group relations).
- **Natural keys (inferred):** The composite of (`menu_id`, `gid`) acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of permissions as of the last ingestion.
- Ensure joins to parent tables handle the integer IDs correctly, as these are typically surrogate keys in the source system.