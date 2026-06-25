# account_fiscal_position_tax

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `account_fiscal_position_tax`, `create_uid`, `write_date`) and the use of specific sequence-based primary keys are characteristic of the Odoo framework's accounting module.

## Functional process 
This table supports the tax mapping process within the accounting module. It defines how taxes are replaced or remapped when a specific fiscal position (e.g., intra-community trade, tax-exempt status) is applied to a transaction, ensuring correct tax calculation based on the customer's or vendor's fiscal context.

## Description
Each row represents a specific tax mapping rule within a fiscal position, defining a source tax that should be replaced by a destination tax. This is a raw landing table in the staging layer, capturing the configuration state of fiscal tax adjustments as defined in the source ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| position_id | INTEGER | false | Foreign key to the fiscal position | Links to the parent fiscal position definition. |
| company_id | INTEGER | true | Company identifier | Multi-tenant identifier for the specific entity. |
| tax_src_id | INTEGER | false | Source tax ID | The original tax to be replaced. |
| tax_dest_id | INTEGER | true | Destination tax ID | The tax that replaces the source tax. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone unknown. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job; timezone unknown. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `position_id` → `account_fiscal_position.id`: Links to the fiscal position header.
    - `tax_src_id` → `account_tax.id`: Links to the tax definition being replaced.
    - `tax_dest_id` → `account_tax.id`: Links to the replacement tax definition.
    - `company_id` → `res_company.id`: Links to the owning company.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are provided as-is from the source; verify if they are stored in UTC or local server time before performing time-series analysis.
- The table does not explicitly indicate soft-delete status; assume all rows are active unless a separate audit log or status column is joined.
- `tax_dest_id` is nullable, which may imply that a source tax is simply removed (not replaced) under certain fiscal positions.
- This is a staging table; expect raw, uncleaned data that may require joining against master data tables for human-readable names.