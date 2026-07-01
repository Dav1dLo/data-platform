# Fully Qualified Name: DWH.DimDate

## Description
A comprehensive date dimension table providing attributes for time-based analysis of sales performance, including calendar, fiscal, and seasonal groupings.

## Grain
One row per calendar day.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| DateKey | SK | integer | 8 | Surrogate key generated as YYYYMMDD. | |
| FullDate | SCD1 | date | 4 | Source system calendar date. | |
| DayOfWeek | SCD1 | varchar(10) | 10 | Name of the day of the week (e.g., Monday). | |
| DayOfMonth | SCD1 | integer | 2 | Day number within the month (1-31). | |
| MonthName | SCD1 | varchar(15) | 15 | Full name of the month (e.g., January). | |
| MonthNumber | SCD1 | integer | 2 | Month number within the year (1-12). | |
| Quarter | SCD1 | varchar(2) | 2 | Calendar quarter (Q1-Q4). | |
| Year | SCD1 | integer | 4 | Calendar year (YYYY). | |
| IsWeekend | SCD1 | boolean | 1 | Flag indicating if the date falls on a Saturday or Sunday. | |

## Transformation Logic
The table is populated by generating a continuous range of dates covering the historical and future requirements of the business. Attributes are derived from the `FullDate` value using standard date/time functions.

## Lineage
- Reads from: None (System-generated dimension)

## Notes
- This dimension is used to support time-series analysis in [DWH.FactSaleOrderLine](../Data Warehouse/Fact/DWH.FactSaleOrderLine.md).
- The `DateKey` is formatted as an integer (YYYYMMDD) to facilitate efficient joins and partitioning in the fact table.