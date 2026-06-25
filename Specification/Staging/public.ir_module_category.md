# ir_module_category

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the `ir_module_category` naming convention, which is a standard internal registry table in Odoo for categorizing software modules. The presence of `create_uid`, `write_uid`, and `JSONB` fields for translatable text is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the module management and application categorization process within the Odoo ecosystem. It defines the hierarchical structure used to group modules (e.g., "Accounting", "Sales", "Inventory") in the application dashboard, allowing for organized navigation and permission management.

## Description
One row in this table represents a single category definition used to group software modules. The grain is one row per category, and it serves as a raw landed copy of the Odoo system's internal module categorization metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_module_category_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users.id`. |
| parent_id | INTEGER | true | Parent category ID | Enables hierarchical categorization. |
| name | JSONB | false | Category name | Multilingual support via JSONB. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| description | JSONB | true | Category description | Multilingual support via JSONB. |
| visible | BOOLEAN | true | Visibility flag | Determines if the category is shown in UI. |
| exclusive | BOOLEAN | true | Exclusivity flag | Indicates if a module can belong to only one category. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id → ir_module_category.id`: Self-referencing key for category hierarchy.
    - `create_uid → res_users.id`: Guessed based on Odoo standard naming conventions for audit fields.
    - `write_uid → res_users.id`: Guessed based on Odoo standard naming conventions for audit fields.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Fields:** The `name` and `description` columns contain JSONB data; queries will need to use PostgreSQL JSON operators (e.g., `->>`) to extract specific language strings.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Fields:** `create_uid` and `write_uid` refer to user IDs in the source system; these will not resolve to meaningful names without joining to the `res_users` table.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed physically if deleted in the source.