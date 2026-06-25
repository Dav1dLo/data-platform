# account_tax_group

## Source system
This table originates from an Odoo ERP system, evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for multi-language fields like `name`. The schema structure is consistent with Odoo's accounting and tax configuration modules.

## Functional process 
This table supports the tax configuration and accounting setup process. It defines groupings of tax accounts used for financial reporting and transaction processing, specifically mapping tax liabilities and receivables to specific ledger accounts (`tax_payable_account_id`, `tax_receivable_account_id`) within a multi-company environment (`company_id`).

## Description
One row in this table represents a single tax group configuration, which acts as a container for tax-related accounting settings. This is a raw landed staging table, providing a direct copy of the source system's tax group definitions used to categorize tax movements in the general ledger.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.account_tax_group_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for sorting tax groups in UI/reports. |
| company_id | INTEGER | false | Foreign key to company | Identifies the organization this tax group belongs to. |
| tax_payable_account_id | INTEGER | true | GL account for tax payable | Linked to the chart of accounts. |
| tax_receivable_account_id | INTEGER | true | GL account for tax receivable | Linked to the chart of accounts. |
| advance_tax_payment_account_id | INTEGER | true | GL account for advance tax | Used for prepayments or tax credits. |
| country_id | INTEGER | true | Foreign key to country | Defines the tax jurisdiction. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| pos_receipt_label | VARCHAR | true | POS receipt display name | Label used specifically on Point of Sale receipts. |
| name | JSONB | false | Tax group name | Multi-language field; usually contains key-value pairs for locales. |
| preceding_subtotal | JSONB | true | Subtotal label | Multi-language label for tax subtotal lines. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company link).
    - `tax_payable_account_id` → `account_account.id` (Links to the general ledger chart of accounts).
    - `tax_receivable_account_id` → `account_account.id` (Links to the general ledger chart of accounts).
    - `country_id` → `res_country.id` (Standard Odoo country reference).
- **Natural keys (inferred):** Not confidently inferable; the `name` field is localized and may not be unique across companies.

## Caveats for downstream consumers

- **JSONB fields:** The `name` and `preceding_subtotal` columns contain JSONB data. Use PostgreSQL `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft deletes:** This table does not appear to implement a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's business logic.
- **Data Integrity:** As a staging table, it may contain orphaned references if the source system allows deletion of linked accounts or companies.