# Fully Qualified Name: DWH.DimSupplier

## Description
This dimension table contains descriptive attributes for suppliers, enabling analysis of procurement activities by supplier entity. It is derived from the Odoo partner master data, specifically filtering for entities identified as suppliers.

## Grain
One row per supplier partner.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| SupplierSK | SK | bigint | bigint | Surrogate key generated via hash or sequence. | |
| SupplierID | PK | integer | integer | Pass-through from public.res_partner.id. | |
| SupplierName | SCD1 | varchar | varchar(255) | Pass-through from public.res_partner.name. | |
| SupplierReference | SCD1 | varchar | varchar(255) | Pass-through from public.res_partner.ref. | |
| TaxIdentificationNumber | SCD1 | varchar | varchar(64) | Pass-through from public.res_partner.vat. | |
| SupplierRank | SCD1 | integer | integer | Pass-through from public.res_partner.supplier_rank. | |
| IsCompany | SCD1 | boolean | boolean | Pass-through from public.res_partner.is_company. | |
| City | SCD1 | varchar | varchar(128) | Pass-through from public.res_partner.city. | |
| CountryID | SCD1 | integer | integer | Pass-through from public.res_partner.country_id. | |
| Email | SCD1 | varchar | varchar(255) | Pass-through from public.res_partner.email. | |
| ActiveStatus | TC | boolean | boolean | Pass-through from public.res_partner.active. | |

## Transformation Logic
The table is populated by selecting records from [public.res_partner](../Staging/public.res_partner.md) where `supplier_rank > 0` and `active = true`.

## Lineage
- Reads from: [public.res_partner](../Staging/public.res_partner.md)

## Notes
- The `SupplierSK` is intended to be a surrogate key to support potential future SCD2 implementation if historical tracking of supplier attributes becomes a requirement.
- The `SupplierRank` column in Odoo indicates the frequency or importance of the supplier; a value greater than 0 confirms the entity is a supplier.
- PII data (email, name) is included as per business requirements for reporting; ensure appropriate access controls are applied in the data warehouse.