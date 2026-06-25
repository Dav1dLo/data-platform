# product_template_attribute_line

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`product_template_attribute_line`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based primary key generation pattern typical of the Odoo framework.

## Functional process 
This table supports the product configuration and catalog management process. It links specific product templates to their available attributes (e.g., color, size) and manages the ordering and metadata of these attribute lines within the product definition.

## Description
One row represents a single attribute line associated with a product template, defining which attribute is available for that product. This is a raw landing table in the staging layer, capturing the configuration state of product attributes as they exist in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_template_attribute_line_id_seq` |
| product_tmpl_id | INTEGER | false | Foreign key to product template | Links to the parent product definition |
| sequence | INTEGER | true | Display order index | Determines UI/catalog sorting order |
| attribute_id | INTEGER | false | Foreign key to attribute definition | Identifies the specific attribute (e.g., Color) |
| value_count | INTEGER | true | Count of attribute values | Denormalized count of available options |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the attribute line is currently enabled |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_tmpl_id` → `product_template.id` (Likely target based on Odoo naming conventions).
    - `attribute_id` → `product_attribute.id` (Likely target based on Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains audit user IDs (`create_uid`, `write_uid`) which may map to internal employee records.
- **Timestamps:** Assumed to be in UTC; verify against source system configuration if precision is required for cross-timezone reporting.
- **Soft Deletes:** The `active` column suggests a soft-delete pattern; ensure queries filter by `active = TRUE` unless historical analysis is required.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the ingestion process is not idempotent or if source system constraints are loose.