# stock_route_categ

## Source system
This table likely originates from an Odoo ERP or a similar modular inventory management system. The naming convention `stock_route_categ` is characteristic of Odoo's database schema, where it serves as a join table linking inventory routes to product categories.

## Functional process 
This table supports the inventory management and logistics configuration process. It defines the many-to-many relationship between stock routes (which dictate how products move through a warehouse, such as "Pick-Pack-Ship") and product categories (which group items for reporting or operational rules).

## Description
One row in this table represents a single association between a specific stock route and a product category. It is a raw landing copy of a junction table used to enforce inventory routing logic based on product classification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Foreign key to the stock route definition. | Links to the primary key of the stock_route table. |
| categ_id | INTEGER | false | Foreign key to the product category definition. | Links to the primary key of the product_category table. |

## Keys

- **Primary key (inferred):** The composite of (`route_id`, `categ_id`).
- **Foreign keys (inferred):** 
    - `route_id` → `stock_route.id`: This column identifies the specific routing rule applied to the category.
    - `categ_id` → `product_category.id`: This column identifies the category of products subject to the route.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- Expect no null values as both columns are required to define the relationship.
- This table does not contain soft-delete flags; if a relationship is removed in the source system, the row is likely physically deleted.