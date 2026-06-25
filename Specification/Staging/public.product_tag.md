# product_tag

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for the `name` field (often used in Odoo for multi-language support), is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the product categorization and tagging process within the product catalog module. It allows users to assign metadata labels to products for filtering, reporting, and organizational purposes, with the `sequence` column likely controlling the display order of these tags in the user interface.

## Description
One row in this table represents a single product tag definition available for assignment to products. This is a raw landed copy of the Odoo `product.tag` model, serving as a staging entity for downstream dimension modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_tag_id_seq` sequence. |
| sequence | INTEGER | true | Display order index | Lower numbers typically appear first. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users.id`. |
| color | VARCHAR | true | UI color identifier | Often stored as an integer string or CSS class name. |
| name | JSONB | false | Tag label | Likely contains localized strings (e.g., `{"en_US": "New", "fr_FR": "Nouveau"}`). |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming convention for audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming convention for audit fields).
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, Odoo tags often allow duplicate names if they belong to different categories or contexts.

## Caveats for downstream consumers

- **PII/Sensitivity:** No direct PII, though `create_uid` and `write_uid` link to user identity tables.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Format:** The `name` column is `JSONB`; ensure your query engine supports extracting keys (e.g., `name->>'en_US'`) if you need to flatten this for reporting.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are active unless an `active` column is present in the source system's full schema.