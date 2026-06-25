# product_attribute

## Source system
The table likely originates from an Odoo ERP system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of a `JSONB` type for the `name` field (common for multi-language support in Odoo) and the specific sequence naming convention, strongly indicates an Odoo backend.

## Functional process 
This table supports the Product Management module, specifically defining the attributes (such as "Color", "Size", or "Material") that can be assigned to product variants. It governs how these attributes are displayed in the user interface and the order in which they appear via the `sequence` column.

## Description
One row in this table represents a single product attribute definition available within the product catalog. This is a raw landed staging table containing the configuration settings for product attributes, including their display behavior and audit metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_attribute_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort attributes in the UI. |
| create_uid | INTEGER | true | ID of the user who created the record | References the users table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the users table. |
| create_variant | VARCHAR | false | Strategy for variant creation | Defines how variants are generated from this attribute. |
| display_type | VARCHAR | false | UI rendering style | e.g., 'radio', 'select', 'color'. |
| name | JSONB | false | Attribute name | Multi-language support; stores localized strings. |
| active | BOOLEAN | true | Soft-delete flag | If false, the attribute is hidden from the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** No PII or financial data; safe for general access.
- **Timestamps:** Assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve only currently valid attributes.
- **JSONB:** The `name` column contains JSON data; use PostgreSQL `->>` operator to extract values (e.g., `name->>'en_US'`).