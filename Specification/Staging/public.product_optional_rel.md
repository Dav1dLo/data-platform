# product_optional_rel

## Source system
The source system is unknown — insufficient evidence. The table name suggests a relationship mapping between products, but the column names lack specific prefixes or suffixes (e.g., `erp_`, `crm_`) that would identify a specific operational system.

## Functional process 
This table supports product catalog management, specifically defining optional or cross-sell relationships between products. It likely maps a primary product to an associated optional product, facilitating "add-on" or "accessory" logic in a sales or e-commerce pipeline.

## Description
One row in this table represents a single directional relationship between two products, where the product identified by `src_id` has an optional association with the product identified by `dest_id`. As a staging table, this represents a raw, landed copy of the relationship mapping, likely extracted directly from the source database's join table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| src_id | INTEGER | false | The identifier of the primary product. | Likely a foreign key to a product master table. |
| dest_id | INTEGER | false | The identifier of the optional product. | Likely a foreign key to a product master table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`src_id`, `dest_id`).
- **Foreign keys (inferred):** 
    - `src_id` → `product.id` (guess: represents the parent product in the relationship).
    - `dest_id` → `product.id` (guess: represents the optional/child product in the relationship).
- **Natural keys (inferred):** 
    - (`src_id`, `dest_id`) as a composite pair representing the unique relationship link.

## Caveats for downstream consumers

- This table contains no metadata columns (e.g., `created_at`, `is_deleted`), so it is impossible to determine the temporal state or soft-delete status of these relationships from the table alone.
- The relationship is likely directional; ensure queries account for whether the association is intended to be symmetric or asymmetric.
- No PII or sensitive financial data is present.