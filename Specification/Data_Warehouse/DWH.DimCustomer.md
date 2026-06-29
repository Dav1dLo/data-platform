# Fully Qualified Name: DWH.DimCustomer

## Description
This dimension table represents customers within the sales process, providing descriptive attributes for analyzing sales performance by customer, industry, and geographic location. It is derived from the Odoo partner master data.

## Grain
One row per customer partner ID.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| CustomerSK | PK | bigint | 8 bytes | Surrogate key generated via hash or sequence. | |
| SourcePartnerID | TC | integer | 4 bytes | Direct mapping from public.res_partner.id. | |
| CustomerName | SCD1 | varchar | 128 | Direct mapping from public.res_partner.name. | |
| IsCompany | SCD1 | boolean | 1 byte | Direct mapping from public.res_partner.is_company. | |
| Industry | SCD1 | varchar | 64 | Derived from public.res_partner.industry_id (lookup). | |
| CustomerCity | SCD1 | varchar | 128 | Direct mapping from public.res_partner.city. | |
| CustomerCountry | SCD1 | varchar | 64 | Derived from public.res_partner.country_id (lookup). | |
| CustomerVAT | SCD1 | varchar | 64 | Direct mapping from public.res_partner.vat. | |
| CustomerType | SCD1 | varchar | 32 | Direct mapping from public.res_partner.type. | |
| IsActive | SCD1 | boolean | 1 byte | Direct mapping from public.res_partner.active. | |

## Transformation Logic
The table is populated by selecting active customer records from [public.res_partner](../Staging/public.res_partner.md). Only records where `customer_rank > 0` are included to ensure the dimension contains relevant sales entities. Lookups for industry names and country names are performed against their respective master tables (assumed available in the source schema).

## Lineage
- Reads from: [public.res_partner](../Staging/public.res_partner.md)

## Notes
- The `CustomerSK` is a surrogate key to support SCD type 2 if historical tracking of customer attributes (like industry or address) becomes a requirement in the future.
- Currently, this dimension is implemented as SCD1.
- `customer_rank` is used as a filter to distinguish customers from suppliers or internal contacts.