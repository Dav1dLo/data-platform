# stock_route_product

## Source system
The source system is unknown — insufficient evidence. The table name suggests a mapping between logistics routes and products, but lacks specific prefixes or naming conventions that would definitively link it to a known ERP or WMS platform.

## Functional process 
This table supports inventory distribution and logistics planning. It functions as a junction table defining which products are assigned to or eligible for specific delivery or transport routes, likely used to optimize load planning or regional product availability.

## Description
One row in this table represents a single association between a specific product and a specific logistics route. It serves as a raw landed copy of a many-to-many relationship mapping, facilitating the join between product catalogs and route definitions in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Unique identifier for the logistics route | Foreign key to a route definition table |
| product_id | INTEGER | false | Unique identifier for the product | Foreign key to a product master table |

## Keys

- **Primary key (inferred):** The combination of (`route_id`, `product_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `route_id` → `route.id` (guess: standard naming convention for route entities).
    - `product_id` → `product.id` (guess: standard naming convention for product entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join/link table; it contains no descriptive attributes or timestamps.
- As a staging table, it may contain orphaned IDs if referential integrity is not enforced at the source.
- There are no sensitive columns (PII) present in this table.