# Fully Qualified Name: DWH.DimSalesTeam

## Description
This dimension table stores descriptive attributes of sales teams, enabling the categorization and analysis of sales performance by organizational unit. It captures team identity, configuration, and performance targets derived from the CRM system.

## Grain
One row per unique sales team.

## SCD Type
Type 2

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| SalesTeamSK | SK | integer | integer | System-generated surrogate key. | |
| SalesTeamBK | BK | integer | integer | Pass-through from public.crm_team.id. | |
| TeamName | SCD2 | varchar(255) | varchar(255) | Extracted from public.crm_team.name (JSONB ->> 'en_US' or default). | |
| IsActive | SCD1 | boolean | boolean | Pass-through from public.crm_team.active. | |
| UseLeads | SCD1 | boolean | boolean | Pass-through from public.crm_team.use_leads. | |
| UseOpportunities | SCD1 | boolean | boolean | Pass-through from public.crm_team.use_opportunities. | |
| InvoicedTarget | SCD1 | numeric(38,6) | numeric(38,6) | Cast public.crm_team.invoiced_target to numeric(38,6). | |

## Transformation Logic
The table is populated by selecting active and inactive sales teams from the source system. The `TeamName` is extracted from the `JSONB` field in the source, assuming a standard language key or default value. The `InvoicedTarget` is cast to a standard numeric type for consistent reporting.

## Lineage
- Reads from: [public.crm_team](../Staging/public.crm_team.md)

## Notes
- The `TeamName` extraction assumes a standard key within the JSONB structure; if multiple languages are required, this should be expanded to include locale-specific columns.
- `InvoicedTarget` precision is set to `numeric(38,6)` to accommodate the `DOUBLE PRECISION` source while ensuring standard financial reporting precision.
