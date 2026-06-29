# Fully Qualified Name: DWH.DimCurrency

## Description
This dimension table provides descriptive attributes for currencies used within the sales and financial reporting processes. It enables the normalization of monetary values by providing metadata such as symbols, rounding rules, and ISO codes.

## Grain
One row per unique currency identifier.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| CurrencySK | PK | integer | integer | Surrogate key generated via sequence. | |
| CurrencyID | SCD1 | integer | integer | Pass-through from `public.res_currency.id`. | |
| CurrencyName | SCD1 | varchar(255) | varchar(255) | Pass-through from `public.res_currency.name`. | |
| CurrencySymbol | SCD1 | varchar(10) | varchar(10) | Pass-through from `public.res_currency.symbol`. | |
| ISONumericCode | SCD1 | integer | integer | Pass-through from `public.res_currency.iso_numeric`. | |
| DecimalPlaces | SCD1 | integer | integer | Pass-through from `public.res_currency.decimal_places`. | |
| SymbolPositions | SCD2 | varchar(20) | varchar(20) | Pass-through from `public.res_currency.position`. | |
| RoundingFactor | SCD1 | numeric(18,6) | numeric(18,6) | Pass-through from `public.res_currency.rounding`. | |
| IsActive | SCD1 | boolean | boolean | Pass-through from `public.res_currency.active`. | |

## Transformation Logic
The table is populated by selecting relevant attributes from `public.res_currency`. A surrogate key (`CurrencySK`) is generated to serve as the primary key for the dimension. The `active` flag is preserved to allow filtering of historical or deactivated currencies in downstream reporting.

## Lineage
- Reads from: [public.res_currency](../Staging/public.res_currency.md)

## Notes
- The `RoundingFactor` and `DecimalPlaces` columns should be used in conjunction when performing currency conversions or financial calculations in the `DWH.FactSalesOrderLine` fact table.
- The `IsActive` flag should be used in all queries to ensure only currently valid currencies are included, unless historical analysis is specifically required.