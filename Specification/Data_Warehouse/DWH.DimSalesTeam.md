# Fully Qualified Name: DWH.DimSalesTeam

## Description
This dimension table represents the organizational structure of sales teams within the company. It provides descriptive attributes for sales teams, enabling the categorization and analysis of sales performance by specific team units.

## Grain
One row per unique sales team.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations | Aggregation |
| --- | --- | --- | --- | --- | --- |
| SalesTeamSK | PK | integer | integer | Surrogate key generated via sequence. | N/A |
| SalesTeamID | SCD1 | integer | integer | Direct mapping from public.crm_team.id. | N/A |
| TeamName | SCD1 | varchar(255) | varchar(255) | Extracted from public.crm_team.name (JSONB ->> 'en_US' or default). | N/A |
| TeamLeaderID | SCD1 | integer | integer | Direct mapping from public.crm_team.user_id. | N/A |
| IsActive | SCD1 | boolean | boolean | Direct mapping from public.crm_team.active. | N/A |
| UseLeads | SCD1 | boolean | boolean | Direct mapping from public.crm_team.use_leads. | N/A |
| UseOpportunities | SCD1 | boolean | boolean | Direct mapping from public.crm_team.use_opportunities. | N/A |
| InvoicedTarget | SCD1 | numeric(18,2) | numeric(18,2) | Cast from public.crm_team.invoiced_target (double precision). | N/A |

## Transformation Logic
The table is populated by selecting relevant attributes from [public.crm_team](../Staging/public.crm_team.md). The `TeamName` is extracted from the JSONB field, defaulting to a standard language key or the first available value. A surrogate key (`SalesTeamSK`) is assigned to uniquely identify each version of the team record.

## Lineage
- Reads from: [public.crm_team](../Staging/public.crm_team.md)

## Notes
- The `InvoicedTarget` is cast to `numeric(18,2)` to ensure financial precision, assuming the source `double precision` values fit within this range.
- `TeamName` sizing is set to `varchar(255)` as a safe default for Odoo JSONB name fields.
- The `active` flag from the source is preserved to allow for filtering of archived teams in downstream reporting.