# Fully Qualified Name: DWH.DimWarehouse

## Description
This dimension table provides descriptive attributes for warehouses, enabling the analysis of sales and inventory performance by physical or logical warehouse location.

## Grain
One row per unique warehouse.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| WarehouseSK | PK | integer | integer | Surrogate key generated via sequence. | |
| WarehouseID | TC | integer | integer | Direct mapping from public.stock_warehouse.id. | |
| WarehouseName | SCD1 | varchar | varchar | Direct mapping from public.stock_warehouse.name. | |
| WarehouseCode | SCD1 | varchar | varchar(5) | Direct mapping from public.stock_warehouse.code. | |
| ReceptionSteps | SCD1 | varchar | varchar | Direct mapping from public.stock_warehouse.reception_steps. | |
| DeliverySteps | SCD1 | varchar | varchar | Direct mapping from public.stock_warehouse.delivery_steps. | |
| IsActive | SCD1 | boolean | boolean | Direct mapping from public.stock_warehouse.active. | |

## Transformation Logic
The table is populated by selecting relevant descriptive attributes from [public.stock_warehouse](../Staging/public.stock_warehouse.md). A surrogate key is generated for the dimension, and the source `id` is retained as a technical column for lineage.

## Lineage
- Reads from: [public.stock_warehouse](../Staging/public.stock_warehouse.md)

## Notes
- The `WarehouseSK` should be implemented as a `SERIAL` or `IDENTITY` column in PostgreSQL.
- Consumers should filter by `IsActive = TRUE` to retrieve only currently operational warehouses.
- The `WarehouseCode` is treated as the natural key for the warehouse entity.