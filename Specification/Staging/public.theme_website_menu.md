# theme_website_menu

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming conventions `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo, as well as the use of `JSONB` for localized fields like `name`.

## Functional process 
This table supports the website content management process, specifically the configuration and hierarchical structure of website navigation menus. It manages how menu items are linked to internal pages or external URLs, their display order, and the configuration of advanced features like mega menus.

## Description
One row in this table represents a single menu item within a website's navigation structure. It captures the hierarchy, display properties, and content of the menu, serving as a raw landing copy of the website configuration from the source ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `theme_website_menu_id_seq`. |
| page_id | INTEGER | true | Foreign key to the linked website page | Links to the internal page content. |
| sequence | INTEGER | true | Display order index | Used to sort menu items. |
| parent_id | INTEGER | true | Parent menu item ID | Defines the hierarchical tree structure. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the system user. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to the system user. |
| url | VARCHAR | true | External or internal URL path | Destination for the menu item. |
| mega_menu_classes | VARCHAR | true | CSS classes for mega menu styling | Used for frontend rendering. |
| name | JSONB | false | Menu label | Likely contains multi-language translations. |
| mega_menu_content | TEXT | true | HTML/XML content for mega menu | Stores the structure of the mega menu. |
| new_window | BOOLEAN | true | Open in new tab flag | Determines browser behavior on click. |
| use_main_menu_as_parent | BOOLEAN | true | Inheritance flag | Indicates if the item inherits from main menu. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `page_id` → `website_page.id` (guess: links to the page definition table).
    - `parent_id` → `theme_website_menu.id` (self-referencing hierarchy).
    - `create_uid` / `write_uid` → `res_users.id` (guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Localization:** The `name` column is `JSONB`; ensure you extract the correct language key (e.g., `name->>'en_US'`) when querying.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Hierarchy:** This table represents a tree structure; recursive CTEs are required to reconstruct the full menu path.
- **Data Integrity:** As a staging table, it may contain orphaned records if the source system has not enforced referential integrity during the extraction process.