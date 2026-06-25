# account_tax

## Source system
The table likely originates from Odoo (formerly OpenERP), as evidenced by the specific column naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for multi-language fields like `name` and `description`, which are characteristic of Odoo's ORM structure.

## Functional process 
This table supports the financial accounting and tax configuration process. It defines the tax rates, calculation methods, and scope (e.g., sales vs. purchase) applied to invoices and financial transactions within the company's accounting module.

## Description
One row in this table represents a single tax definition or tax rule configured within the accounting system. It serves as a raw landed copy of the tax configuration entity, capturing the tax rate, its applicability, and its behavior regarding base amounts and invoice presentation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_tax_id_seq`. |
| company_id | INTEGER | false | Foreign key to the owning company | Links to the multi-company structure. |
| sequence | INTEGER | false | Display/calculation order | Determines priority or order of tax application. |
| tax_group_id | INTEGER | false | Foreign key to tax group | Groups taxes for reporting purposes. |
| cash_basis_transition_account_id | INTEGER | true | Account for cash basis accounting | Used for tax exigibility on cash basis. |
| country_id | INTEGER | false | Foreign key to country | Defines the tax jurisdiction. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for record creation. |
| write_uid | INTEGER | true | User ID who last modified the record | Audit trail for record updates. |
| type_tax_use | VARCHAR | false | Tax usage type | e.g., 'sale', 'purchase', or 'none'. |
| tax_scope | VARCHAR | true | Scope of the tax | e.g., 'service' or 'consu'. |
| amount_type | VARCHAR | false | Calculation method | e.g., 'percent', 'fixed', 'division'. |
| price_include_override | VARCHAR | true | Price inclusion behavior | Overrides default tax inclusion settings. |
| tax_exigibility | VARCHAR | true | Tax exigibility trigger | e.g., 'on_invoice', 'on_payment'. |
| name | JSONB | false | Tax name | Multi-language support via JSONB. |
| description | JSONB | true | Tax description | Multi-language support via JSONB. |
| invoice_label | JSONB | true | Label for invoice printouts | Multi-language support via JSONB. |
| invoice_legal_notes | TEXT | true | Legal notes for invoices | Legal disclaimer text. |
| amount | NUMERIC | false | Tax rate or fixed amount | Value depends on `amount_type`. |
| active | BOOLEAN | true | Soft-delete flag | If false, the tax is deprecated. |
| include_base_amount | BOOLEAN | true | Include in base amount | Whether this tax affects the base for others. |
| is_base_affected | BOOLEAN | true | Is base affected | Whether this tax is affected by other taxes. |
| analytic | BOOLEAN | true | Analytic accounting flag | Whether tax impacts analytic accounts. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
    - `tax_group_id` → `account_tax_group.id` (Groups taxes for reporting)
    - `country_id` → `res_country.id` (Geographic jurisdiction)
    - `create_uid` / `write_uid` → `res_users.id` (User audit trail)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but contains financial configuration data.
- **Timestamps:** Assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = true` to see currently valid taxes.
- **JSONB:** The `name`, `description`, and `invoice_label` columns are `JSONB` and may require extraction (e.g., `name->>'en_US'`) depending on the desired language.
- **Data Pattern:** This is a staging table; expect raw data types and potential schema evolution.