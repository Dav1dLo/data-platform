# pos_category

## Source system
This table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for the `name` field are characteristic patterns of Odoo's PostgreSQL-based ORM layer, specifically within the Point of Sale (POS) module.

## Functional process 
This table supports the Point of Sale (POS) product categorization process. It maintains a hierarchical structure of categories used to organize products within the POS interface, allowing for nested category trees via the `parent_id` relationship and custom UI ordering via the `sequence` column.

## Description
One row in this table represents a single product category within the Point of Sale system. It serves as a raw landed copy of the category definition, capturing metadata such as hierarchy, display order, and audit timestamps for record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.pos_category_id_seq`. |
| parent_id | INTEGER | true | Self-referencing foreign key | Points to the parent category ID for hierarchy. |
| sequence | INTEGER | true | Display order index | Used to sort categories in the POS UI. |
| color | INTEGER | true | UI color index | Represents the color code assigned to the category. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | JSONB | false | Category name | Multi-language string stored as JSON. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the system upon insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the system upon modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `public.pos_category.id`: Establishes the category tree hierarchy.
    - `create_uid` → `public.res_users.id` (guess): Likely links to the system user who created the record.
    - `write_uid` → `public.res_users.id` (guess): Likely links to the system user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is a `JSONB` object; you will likely need to extract the specific language key (e.g., `name->>'en_US'`) to use it in reports.
- Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo-based systems, but verify against your specific instance configuration.
- This table does not implement soft deletes; records are typically hard-deleted in the source system.
- The `color` column is an integer index mapping to a predefined UI color palette in the frontend application.