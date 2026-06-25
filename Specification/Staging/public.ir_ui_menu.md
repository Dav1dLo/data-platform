# ir_ui_menu

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_ui_menu` (Internal Resource User Interface Menu) and the presence of columns like `parent_path`, `create_uid`, and `write_uid` are characteristic of Odoo's internal metadata tables used to manage the application's navigation structure.

## Functional process 
This table supports the application's navigation and user interface configuration. It defines the hierarchical menu structure displayed to users within the Odoo web client, mapping menu items to specific actions and defining their display order and visibility.

## Description
One row in this table represents a single menu item within the Odoo application interface. The table is stored at the grain of one row per menu node, capturing the hierarchical relationship via `parent_id` and `parent_path`. It serves as a raw landed copy of the system's menu configuration, used to reconstruct the navigation tree for user sessions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique identifier for the menu item | Primary key; managed by `ir_ui_menu_id_seq` |
| sequence | INTEGER | true | Display order index | Lower numbers appear first in the UI |
| parent_id | INTEGER | true | Reference to the parent menu item | Used to build the navigation hierarchy |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users` |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users` |
| parent_path | VARCHAR | true | Materialized path of the menu hierarchy | Used for efficient tree traversal |
| web_icon | VARCHAR | true | Icon path or definition for the menu | Used for UI rendering |
| action | VARCHAR | true | Associated action or view trigger | Defines what happens when the menu is clicked |
| name | JSONB | false | Display name of the menu item | Often contains multi-language translations |
| active | BOOLEAN | true | Soft-delete flag | If false, the menu is hidden from the UI |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `ir_ui_menu.id`: Defines the parent-child relationship in the menu tree.
    - `create_uid` → `res_users.id` (guess): Tracks the creator of the menu configuration.
    - `write_uid` → `res_users.id` (guess): Tracks the last modifier of the menu configuration.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; this table contains UI configuration metadata.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = true` to retrieve only currently visible menu items.
- **JSONB:** The `name` column is a `JSONB` object; use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract specific language strings.
- **Hierarchy:** The `parent_path` column is a materialized path (e.g., "1/5/12") which can be used for fast hierarchical filtering using the `ltree` extension or string pattern matching.