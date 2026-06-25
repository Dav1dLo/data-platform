# account_analytic_distribution_model

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `company_id`, `product_categ_id`) and the use of `JSONB` for analytic distributions are characteristic of Odoo's financial and accounting modules.

## Functional process 
This table supports the automated financial accounting process, specifically the "Analytic Accounting" module. It defines rules for how costs and revenues are automatically distributed across analytic accounts based on criteria such as partners, products, or account prefixes.

## Description
One row in this table represents a single configuration rule for analytic distribution. It defines the logic used to split financial entries into specific analytic accounts when certain conditions (like a specific product or partner) are met. This is a raw landed copy from the Odoo staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_analytic_distribution_model_id_seq` |
| sequence | INTEGER | true | Priority order for rule application | Lower numbers typically indicate higher priority |
| partner_id | INTEGER | true | Foreign key to specific partner | Links to `res_partner` |
| partner_category_id | INTEGER | true | Foreign key to partner category | Links to `res_partner_category` |
| company_id | INTEGER | true | Foreign key to owning company | Links to `res_company` |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users` |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users` |
| analytic_distribution | JSONB | true | Distribution mapping | Contains the analytic account IDs and percentage splits |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed |
| product_id | INTEGER | true | Foreign key to specific product | Links to `product_product` |
| product_categ_id | INTEGER | true | Foreign key to product category | Links to `product_category` |
| account_prefix | VARCHAR | true | Account code prefix filter | Used to match general ledger accounts |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo naming for partner references)
    - `company_id` → `res_company.id` (Standard Odoo naming for multi-company support)
    - `product_id` → `product_product.id` (Standard Odoo naming for product references)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The `analytic_distribution` column is a `JSONB` object; downstream consumers will need to use PostgreSQL JSON operators (e.g., `->>`, `jsonb_array_elements`) to parse the distribution percentages.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage.
- This table contains no explicit soft-delete flag; records are likely managed via direct updates or deletions in the source system.
- The `account_prefix` column allows for partial matching on GL account codes, which may require regex or `LIKE` operations in downstream logic.