# website_menu

## Source system
The table likely originates from an Odoo ERP or a similar modular web-content management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the use of `JSONB` for localized fields and `nextval` sequences, is highly characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the website navigation and menu structure management process. It defines the hierarchical layout of website menus, linking specific URLs or internal pages to a navigation tree, and managing display properties such as mega-menu configurations and window-opening behavior.

## Description
One row in this table represents a single menu item within a website's navigation structure. This is a raw landing copy of the source system's menu configuration, capturing the tree hierarchy via `parent_id` and `parent_path` at the grain of an individual menu node.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `website_menu_id_seq`. |
| page_id | INTEGER | true | Reference to the associated page | Foreign key to a pages table. |
| controller_page_id | INTEGER | true | Reference to a controller-based page | Used for dynamic route handling. |
| sequence | INTEGER | true | Display order index | Used for sorting menu items. |
| website_id | INTEGER | true | Identifier for the specific website | Links menu to a multi-site instance. |
| parent_id | INTEGER | true | Parent menu item ID | Enables recursive tree structure. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail for modification. |
| theme_template_id | INTEGER | true | Associated theme template ID | Links menu to visual styling. |
| url | VARCHAR | true | Target URL path | The destination link for the menu. |
| parent_path | VARCHAR | true | Materialized path for tree traversal | String representation of the hierarchy. |
| mega_menu_classes | VARCHAR | true | CSS classes for mega menu styling | Used for frontend rendering. |
| name | JSONB | false | Display name of the menu item | Likely contains multi-language strings. |
| mega_menu_content | JSONB | true | Content configuration for mega menus | Stores complex layout data. |
| new_window | BOOLEAN | true | Flag to open link in new tab | UI behavior toggle. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `page_id` → `website_page.id` (guess: links to the primary content page).
    - `website_id` → `website.id` (guess: links to the parent website configuration).
    - `parent_id` → `website_menu.id` (self-referencing key for tree structure).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Data:** The `name` and `mega_menu_content` columns contain nested JSON structures; ensure your query logic handles key extraction (e.g., `name->>'en_US'`).
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Hierarchy:** The `parent_path` column is a materialized path (e.g., "1/5/12"); this is useful for efficient recursive queries but should be treated as a denormalized helper.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are currently active unless otherwise specified by the source system's business logic.