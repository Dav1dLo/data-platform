# stock_lot

## Source system
This table originates from an Odoo ERP system. The naming conventions (`product_uom_id`, `create_uid`, `write_uid`, `write_date`) and the use of `JSONB` for properties and pricing are characteristic of Odoo's PostgreSQL-based backend architecture.

## Functional process 
This table supports the inventory management and supply chain process, specifically tracking individual batches or lots of products. It is used to maintain traceability for items within a warehouse, linking specific stock lots to products, locations, and internal company entities.

## Description
One row in this table represents a single stock lot or batch record for a specific product. It serves as a raw landing copy of the Odoo `stock.lot` model, capturing the identification, reference, and metadata associated with a physical inventory batch.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `public.stock_lot_id_seq`. |
| product_id | INTEGER | false | Foreign key to the product | Links to the product definition. |
| product_uom_id | INTEGER | true | Unit of measure ID | Defines the quantity unit for this lot. |
| company_id | INTEGER | true | Owning company ID | Multi-company context identifier. |
| location_id | INTEGER | true | Inventory location ID | The physical or logical warehouse location. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Lot/Serial number | The human-readable identifier for the lot. |
| ref | VARCHAR | true | Internal reference | Secondary reference code or vendor batch ID. |
| lot_properties | JSONB | true | Dynamic attributes | Flexible storage for custom lot-specific fields. |
| note | TEXT | true | Internal notes | Free-text description or comments. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |
| standard_price | JSONB | true | Costing information | Price data stored in JSONB format. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Inferred from Odoo standard naming).
    - `company_id` → `res_company.id` (Inferred from Odoo standard naming).
    - `location_id` → `stock_location.id` (Inferred from Odoo standard naming).
- **Natural keys (inferred):** 
    - `name` (The lot/serial number is typically unique per product in Odoo).

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains `JSONB` columns (`lot_properties`, `standard_price`); ensure your query engine supports JSON path extraction (e.g., `->>` or `jsonb_extract_path_text`).
- No explicit soft-delete flag is present; assume standard Odoo behavior where records are either active or removed from the source.
- `standard_price` may contain nested currency or cost-basis data; inspect the JSON structure before performing aggregations.