# Fully Qualified Name: DWH.DimProduct

## Description
This table represents the master dimension for products within the organization, containing physical attributes and lifecycle status for each product entity. It serves as the primary reference for product-related reporting and analysis.

## Grain
One row per product surrogate key.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- |
| ProductSK | SK | INTEGER | Surrogate key generated as a unique identifier for the dimension record. | N/A |
| ProductID | PK | INTEGER | Natural key sourced from the source system product identifier. | N/A |
| ProductTemplateID | FK | INTEGER | Foreign key referencing the product template definition. | N/A |
| SKU | - | VARCHAR(255) | Stock Keeping Unit identifier. | N/A |
| Barcode | - | VARCHAR(255) | Global Trade Item Number or internal barcode. | N/A |
| Volume | - | NUMERIC | Physical volume measurement of the product. | Sum |
| Weight | - | NUMERIC | Physical weight measurement of the product. | Sum |
| IsActive | SCD1 | BOOLEAN | Flag indicating if the product is currently active in the catalog. | N/A |
| CreatedAt | TC | TIMESTAMP | Timestamp of the initial record creation. | N/A |
| UpdatedAt | TC | TIMESTAMP | Timestamp of the last record modification. | N/A |

## Transformation Logic
The table is populated by extracting product data from the staging layer, mapping source identifiers to surrogate keys, and applying SCD Type 1 logic for status updates. It joins with product template metadata to enrich the dimension.

## Lineage
- Reads from: [Staging.Product](../Staging/Raw/Staging.Product.md)
- Reads from: [Staging.ProductTemplate](../Staging/Raw/Staging.ProductTemplate.md)

## Notes
- The `ProductSK` is the recommended join key for all fact tables.
- `Volume` and `Weight` units are assumed to be consistent across the dataset; verify unit conversion logic in the staging layer if discrepancies arise.
- `IsActive` should be used to filter the dimension for current product catalogs in standard reporting.