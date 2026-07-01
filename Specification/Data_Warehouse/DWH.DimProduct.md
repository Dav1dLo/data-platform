# Fully Qualified Name: DWH.DimProduct

## Description
Represents the catalog of products and product variants available for sale, providing descriptive attributes and hierarchical categorization for sales reporting.

## Grain
One row per product variant.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| ProductKey | SK | integer | integer | System-generated surrogate key. | |
| ProductBK | BK | integer | integer | Direct mapping from public.product_product.id. | |
| SKU | SCD1 | varchar | varchar(255) | Direct mapping from public.product_product.default_code. | |
| ProductName | SCD1 | varchar | varchar(255) | Extracted from public.product_template.name ->> 'en_US'. | |
| ProductType | SCD1 | varchar | varchar(50) | Direct mapping from public.product_template.type. | |
| Barcode | SCD1 | varchar | varchar(255) | Direct mapping from public.product_product.barcode. | |
| ProductCategoryKey | FK | integer | integer | Lookup from DWH.DimProductCategory.ProductCategoryKey where DWH.DimProductCategory.ProductCategoryBK = public.product_template.categ_id. | |
| IsActive | SCD1 | boolean | boolean | Direct mapping from public.product_product.active. | |
| ListPrice | SCD1 | numeric | numeric(18,4) | Direct mapping from public.product_template.list_price. | |
| Weight | SCD1 | numeric | numeric(18,4) | Direct mapping from public.product_product.weight. | |
| Volume | SCD1 | numeric | numeric(18,4) | Direct mapping from public.product_product.volume. | |

## Transformation Logic
The table is populated by joining `public.product_product` (variants) with `public.product_template` (base definitions) on `product_product.product_tmpl_id = product_template.id`. The `ProductCategoryKey` is resolved by joining to `DWH.DimProductCategory` using the `categ_id` from the template. Attributes are selected to provide a comprehensive view of the product variant, with JSONB fields from the template extracted for the primary language (en_US).

## Lineage
- Reads from: [public.product_product](../Staging/public.product_product.md)
- Reads from: [public.product_template](../Staging/public.product_template.md)
- Reads from: [DWH.DimProductCategory](../Data Warehouse/Dimension/DWH.DimProductCategory.md)

## Notes
- The `ProductBK` is the Odoo `product_product.id`.
- `ProductName` assumes the existence of an 'en_US' key within the Odoo JSONB name field.
- As an SCD Type 1 dimension, updates to product attributes (e.g., price, name) will overwrite existing records.