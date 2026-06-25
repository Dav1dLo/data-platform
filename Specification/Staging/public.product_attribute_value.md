# product_attribute_value

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`, `JSONB` for translatable fields) and the specific sequence-based ID generation are characteristic of Odoo's ORM layer.

## Functional process 
This table supports the Product Catalog management process, specifically defining the available values for product attributes (e.g., if the attribute is "Size", this table contains "Small", "Medium", "Large"). It links specific attribute values to products and manages their display properties, such as associated colors or extra pricing.

## Description
One row in this table represents a single selectable value for a specific product attribute. It acts as a raw landed copy of the Odoo `product.attribute.value` model, capturing the configuration, display properties, and audit metadata for each attribute value.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_attribute_value_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort values in the UI. |
| attribute_id | INTEGER | false | Foreign key to parent attribute | Links to the `product.attribute` model. |
| color | INTEGER | true | Color index | Internal Odoo color mapping. |
| create_uid | INTEGER | true | Creator user ID | References `res.users`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res.users`. |
| html_color | VARCHAR | true | CSS color code | Hex code for visual representation. |
| name | JSONB | false | Value name | Multi-language support via JSONB. |
| is_custom | BOOLEAN | true | Custom value flag | Indicates if the value is user-defined. |
| active | BOOLEAN | true | Soft-delete flag | If false, the value is hidden from the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| default_extra_price | DOUBLE PRECISION | true | Price adjustment | Additional cost for this specific value. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `attribute_id` → `product_attribute.id`: Links the value to its parent attribute definition.
    - `create_uid` → `res_users.id`: Tracks which user created the record.
    - `write_uid` → `res_users.id`: Tracks which user last modified the record.
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, Odoo typically relies on the surrogate `id` for uniqueness across locales.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; contains product configuration data.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical analysis is required.
- **JSONB:** The `name` column is stored as `JSONB`. Use the `->>` operator to extract the string value (e.g., `name->>'en_US'`).
- **Data Layer:** This is a raw staging table; expect frequent schema evolution and potential duplicates if the upstream system performs full refreshes.