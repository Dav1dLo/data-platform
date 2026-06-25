# account_fiscal_position

## Source system
This table originates from Odoo ERP. The naming convention `account_fiscal_position` combined with columns like `company_id`, `create_uid`, and `write_uid` is characteristic of Odoo's internal accounting module structure.

## Functional process 
This table supports the tax mapping and fiscal configuration process. It defines rules for how taxes are applied based on customer location (country, zip code range) or VAT status, ensuring that the correct tax rates are applied to invoices and sales orders based on the fiscal position of the counterparty.

## Description
One row represents a single fiscal position rule, which acts as a tax-mapping configuration for specific business scenarios. This is a raw landed copy from the Odoo staging layer, capturing the configuration state used to determine tax behavior for transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| sequence | INTEGER | true | Sorting priority | Determines the order in which rules are evaluated. |
| company_id | INTEGER | false | Owning company ID | Links the rule to a specific entity in a multi-company setup. |
| country_id | INTEGER | true | Target country ID | The country to which this fiscal position applies. |
| country_group_id | INTEGER | true | Target country group ID | The group of countries to which this fiscal position applies. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| zip_from | VARCHAR | true | Starting zip code | Lower bound of the zip code range for this rule. |
| zip_to | VARCHAR | true | Ending zip code | Upper bound of the zip code range for this rule. |
| foreign_vat | VARCHAR | true | Foreign VAT number | VAT identifier associated with this fiscal position. |
| name | JSONB | false | Fiscal position name | Multilingual label for the fiscal position. |
| note | JSONB | true | Description/Notes | Multilingual internal notes or instructions. |
| active | BOOLEAN | true | Active status | Soft-delete flag; if false, the rule is ignored. |
| auto_apply | BOOLEAN | true | Auto-apply flag | If true, the system attempts to detect and apply this rule automatically. |
| vat_required | BOOLEAN | true | VAT requirement flag | Indicates if a VAT number is mandatory for this position. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company link).
    - `country_id` → `res_country.id` (Standard Odoo country reference).
    - `country_group_id` → `res_country_group.id` (Standard Odoo country group reference).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Columns:** The `name` and `note` columns contain JSONB data; use PostgreSQL `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Timestamps:** All timestamps are assumed to be in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` to retrieve only current configurations.
- **Multi-company:** This table is shared across companies; always filter by `company_id` to avoid cross-company data leakage.