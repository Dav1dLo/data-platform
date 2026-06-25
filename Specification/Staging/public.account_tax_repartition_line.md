# account_tax_repartition_line

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `account_tax_repartition_line`, `create_uid`, `write_uid`, `company_id`) is characteristic of the Odoo accounting module's internal data structures for managing tax distribution logic.

## Functional process 
This table supports the tax configuration and accounting reporting process. It defines how tax amounts are distributed across different general ledger accounts based on the tax type and document context (e.g., invoices vs. credit notes), which is essential for accurate tax liability tracking and financial statement preparation.

## Description
One row in this table represents a single distribution rule for a specific tax, determining which general ledger account should be impacted by a percentage of the tax amount. As a staging table, it serves as a raw, landed copy of the Odoo configuration data, intended for use in downstream transformation layers to build analytical tax reporting models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_tax_repartition_line_id_seq`. |
| account_id | INTEGER | true | Foreign key to the general ledger account | Links to the account where the tax amount is posted. |
| tax_id | INTEGER | true | Foreign key to the tax definition | Identifies the parent tax rule. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization owning this tax rule. |
| sequence | INTEGER | true | Sorting order | Determines the priority of repartition lines. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| repartition_type | VARCHAR | false | Type of repartition | Defines if the line is for base or tax amount. |
| document_type | VARCHAR | false | Document context | e.g., 'invoice' or 'refund'. |
| factor_percent | NUMERIC | false | Distribution percentage | The portion of the tax applied to this account. |
| use_in_tax_closing | BOOLEAN | true | Tax closing flag | Indicates if this line is used in periodic tax closing. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `account_account.id` (Guess: links to the chart of accounts).
    - `tax_id` → `account_tax.id` (Guess: links to the tax definition table).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains internal system IDs and configuration logic; no direct PII, but reflects financial configuration.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume it contains only current records or that deletions are hard-deleted in the source.
- **Data Integrity:** `account_id`, `tax_id`, and `company_id` are nullable, which may indicate orphaned records or global tax rules not tied to a specific company.