# stock_warn_insufficient_qty_scrap

## Source system
This table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`, `product_uom_name`) is highly characteristic of Odoo's internal ORM structure for tracking record creation and modification.

## Functional process 
This table supports inventory management and quality control processes, specifically tracking instances where scrap operations were attempted but failed due to insufficient stock levels. It acts as a warning or log mechanism to alert warehouse operators when a requested scrap quantity exceeds the available on-hand inventory for a specific product at a specific location.

## Description
One row in this table represents a single logged warning event for an insufficient quantity during a scrap operation. It captures the product, the target location, the associated scrap reference, and the quantity that triggered the warning. As a staging table, it serves as a raw, direct copy of the operational warning logs from the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| product_id | INTEGER | false | Foreign key to the product | Identifies the item being scrapped. |
| location_id | INTEGER | false | Foreign key to the warehouse location | Identifies where the scrap was attempted. |
| scrap_id | INTEGER | true | Foreign key to the scrap operation | Links to the parent scrap record, if available. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| product_uom_name | VARCHAR | false | Unit of measure name | e.g., "Units", "kg", "liters". |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| quantity | DOUBLE PRECISION | false | The quantity that triggered the warning | The amount requested for scrap. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: standard Odoo product reference)
    - `location_id` → `stock_location.id` (Guess: standard Odoo location reference)
    - `scrap_id` → `stock_scrap.id` (Guess: standard Odoo scrap reference)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `scrap_id` is nullable, suggesting that some warnings may be generated before a formal scrap record is fully persisted or linked.
- **Sensitive Data:** This table contains internal system IDs (`create_uid`, `write_uid`) which may map to employee or user names in other tables; ensure appropriate access controls are applied if joining with user metadata.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all rows are current unless otherwise specified by the source system's business logic.