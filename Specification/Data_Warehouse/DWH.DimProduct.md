# Fully Qualified Name: DWH.DimProduct

## Description
This dimension table provides descriptive attributes for products, enabling the categorization and analysis of sales performance by specific product variants. It consolidates product variant information to support reporting on SKU-level revenue and inventory metrics.

## Grain
One row per product variant.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| ProductSK | SK | bigint | bigint | Surrogate key generated via sequence. | |
| ProductId | TC | integer | integer | Direct mapping from public.product_product.id. | |
| ProductTemplateId | TC | integer | integer | Direct mapping from public.product_product.product_tmpl_id. | |
| SKU | SCD1 | varchar(255) | varchar(255) | Direct mapping from public.product_product.default_code. | |
| Barcode | SCD1 | varchar(255) | varchar(255) | Direct mapping from public.product_product.barcode. | |
| Volume | SCD1 | numeric(18,6) | numeric(18,6) | Direct mapping from public.product_product.volume. | |
| Weight | SCD1 | numeric(18,6) | numeric(18,6) | Direct mapping from public.product_product.weight. | |
| IsActive | SCD1 | boolean | boolean | Direct mapping from public.product_product.active. | |
| CreatedAt | TC | timestamp | timestamp | Direct mapping from public.product_product.create_date. | |
| UpdatedAt | TC | timestamp | timestamp | Direct mapping from public.product_product.write_date. | |

## Transformation Logic
The table is populated by selecting relevant attributes from [public.product_product](../Staging/public.product_product.md). A surrogate key (`ProductSK`) is generated to serve as the primary key for the dimension, while the original Odoo `id` is retained as a technical column for lineage and potential joins to other Odoo-based staging tables.

## Lineage
- Reads from: [public.product_product](../Staging/public.product_product.md)

## Notes
- The `SKU` and `Barcode` fields are sized to `varchar(255)` as a safe default for string identifiers where exact source length constraints were not explicitly defined in the staging metadata.
- `Volume` and `Weight` are mapped to `numeric(18,6)` to accommodate standard precision for physical measurements.
- The `IsActive` flag should be used to filter out archived products in standard reporting scenarios.