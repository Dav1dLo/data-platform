# Fully Qualified Name: DWH.DimCustomer

## Description
Represents a customer entity within the sales process, derived from the Odoo partner master data. This dimension captures contact information, geographic details, and classification attributes to support customer-centric sales performance analysis.

## Grain
One row per customer partner.

## SCD Type
Type 1

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| CustomerKey | SK | integer | 4 bytes | System-generated surrogate key. | |
| CustomerBK | BK | integer | 4 bytes | Pass-through from public.res_partner.id. | |
| CustomerName | SCD1 | varchar(255) | 255 | Pass-through from public.res_partner.name. | |
| CustomerVAT | SCD1 | varchar(64) | 64 | Pass-through from public.res_partner.vat. | |
| CustomerEmail | SCD1 | varchar(255) | 255 | Pass-through from public.res_partner.email. | |
| CustomerCity | SCD1 | varchar(128) | 128 | Pass-through from public.res_partner.city. | |
| CustomerCountryID | SCD1 | integer | 4 bytes | Pass-through from public.res_partner.country_id. | |
| IsCompany | SCD1 | boolean | 1 byte | Pass-through from public.res_partner.is_company. | |
| CustomerRank | SCD1 | integer | 4 bytes | Pass-through from public.res_partner.customer_rank. | |

## Transformation Logic
The dimension is populated by selecting active customer records from the `public.res_partner` table. A filter `active = true` is applied to ensure only current records are included. The `customer_rank` column is used to identify entities that have acted as customers.

## Lineage
- Reads from: [public.res_partner](../Staging/public.res_partner.md)

## Notes
- The `CustomerBK` maps directly to the Odoo `res_partner.id`.
- Only records where `customer_rank > 0` are considered relevant for sales reporting.
- PII data such as email and VAT are included; ensure appropriate access controls are applied in the reporting layer.