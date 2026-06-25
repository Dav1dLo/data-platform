# product_tag_product_product_rel

## Source system
The table likely originates from a Django-based application or a similar ORM-driven system. The naming convention `product_tag_product_product_rel` is characteristic of an auto-generated many-to-many relationship table created by an ORM to link a `product` entity with a `product_tag` entity.

## Functional process 
This table supports the product categorization and tagging process. It acts as a junction table that enables a many-to-many relationship, allowing individual products to be associated with multiple tags (e.g., "New Arrival", "Sale", "Eco-friendly") and tags to be associated with multiple products.

## Description
One row in this table represents a single association between a specific product and a specific product tag. It is a raw landed copy of the junction table used to resolve many-to-many relationships in the staging layer, ensuring that product-to-tag mappings are preserved for downstream modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_product_id | INTEGER | false | Foreign key referencing the product entity. | Maps to the primary key of the products table. |
| product_tag_id | INTEGER | false | Foreign key referencing the product tag entity. | Maps to the primary key of the product_tags table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(product_product_id, product_tag_id)`.
- **Foreign keys (inferred):** 
    - `product_product_id` → `product_product.id` (Inferred from naming convention).
    - `product_tag_id` → `product_tag.id` (Inferred from naming convention).
- **Natural keys (inferred):** The combination of `(product_product_id, product_tag_id)` acts as the unique business key for the relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should treat the combination of both columns as the unique identifier.
- There is no metadata regarding soft deletes; assume this table represents the current state of associations as captured during the last ingestion.
- Ensure that joins to parent tables handle potential orphan records if referential integrity is not strictly enforced at the source.