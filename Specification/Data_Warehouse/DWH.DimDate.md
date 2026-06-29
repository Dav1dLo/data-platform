# Fully Qualified Name: DWH.DimDate

## Description
A standard calendar dimension table used to support time-based analysis of procurement activities. It provides descriptive attributes for dates, enabling filtering and grouping by year, quarter, month, and day.

## Grain
One row per calendar day.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| DateKey | PK | integer | 8 | Integer representation of date (YYYYMMDD). | N/A |
| FullDate | SCD1 | date | 4 | The actual calendar date. | N/A |
| DayOfWeek | SCD1 | varchar(10) | 10 | Name of the day (e.g., Monday). | N/A |
| DayOfMonth | SCD1 | integer | 4 | Day number within the month (1-31). | N/A |
| MonthName | SCD1 | varchar(10) | 10 | Name of the month (e.g., January). | N/A |
| MonthNumber | SCD1 | integer