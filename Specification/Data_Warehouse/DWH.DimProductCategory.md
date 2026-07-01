# Fully Qualified Name: DWH.DimProductCategory

## Description
Represents the hierarchical classification of products, used to group items for reporting and to define inventory and accounting behaviors.

## Grain
One row per product category.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| ProductCategoryKey | SK | integer | integer | System-generated surrogate key. | |
| ProductCategoryBK | BK | integer | integer | Direct mapping from public.product_category.id. | |
| CategoryName | SCD1 | varchar | varchar(255) | Direct mapping from public.product_category.name. | |
| FullCategoryPath | SCD1 | varchar | varchar(255) | Direct mapping from public.product_category.complete_name. | |
| ParentCategoryBK | SCD1 | integer | integer | Direct mapping from public.product_category.parent_id. | |
| MaterializedPath | SCD1 | varchar | varchar(255) | Direct mapping from public.product_category.parent_path. | |

## Transformation Logic
The table is populated by extracting records from the `public.product_category` staging table. The surrogate key `ProductCategoryKey` is generated as a unique identifier for the warehouse. Business keys and descriptive attributes are mapped directly from the source.

## Lineage
- Reads from: [public.product_category](../Staging/public.product_category.md)

## Notes
- The `ProductCategoryBK` corresponds to the `id` in the source Odoo system.
- This dimension is designed to support hierarchical reporting using the `MaterializedPath` column.
- As an SCD Type 1 dimension, changes to category names or paths will overwrite existing records.