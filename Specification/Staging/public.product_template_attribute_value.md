# product_template_attribute_value

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention of columns like `product_tmpl_id`, `attribute_line_id`, `create_uid`, and `write_uid`, which are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the product configuration and variant management process. It links specific attribute values (e.g., "Blue", "Large") to product templates and attribute lines, allowing the system to calculate price adjustments (`price_extra`) for specific product variants.

## Description
One row represents a specific attribute value assigned to a product template, defining how a product variant is configured. This is a raw landing table in the Staging layer, capturing the relationship between product templates and their configurable attributes as stored in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses Odoo sequence generator |
| product_attribute_value_id | INTEGER | false | Reference to the attribute value definition | Foreign key to attribute value master |
| attribute_line_id | INTEGER | false | Reference to the product attribute line | Links to the specific attribute configuration |
| product_tmpl_id | INTEGER | true | Reference to the product template | The product this attribute value applies to |
| attribute_id | INTEGER | true | Reference to the attribute | The category of the attribute (e.g., Color, Size) |
| color | INTEGER | true | Color index or code | Used for UI rendering in Odoo |
| create_uid | INTEGER | true | User ID who created the record | Reference to res.users |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to res.users |
| price_extra | NUMERIC | true | Additional cost for this variant | Unit price adjustment |
| ptav_active | BOOLEAN | true | Soft-delete flag | Indicates if the attribute value is currently enabled |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_tmpl_id` → `product_template.id` (Likely target based on Odoo naming conventions)
    - `attribute_id` → `product_attribute.id` (Likely target based on Odoo naming conventions)
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit columns)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `ptav_active` column should be checked; rows where `ptav_active` is `false` are logically deleted and should generally be excluded from reporting.
- **Timestamps:** Timestamps are stored in the Odoo system time, typically UTC.
- **Data Integrity:** As a staging table, this may contain orphaned records if the source system's referential integrity is not strictly enforced at the database level.
- **Pricing:** `price_extra` represents a delta; ensure this is handled correctly when aggregating total product costs.