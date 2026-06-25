# account_analytic_applicability

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `analytic_plan_id`) and the specific sequence-based primary key pattern are characteristic of Odoo's PostgreSQL-backed database schema.

## Functional process 
This table supports the configuration of analytic accounting rules within the financial module. It defines the applicability of analytic plans to specific business domains, product categories, or account prefixes, effectively determining how financial transactions are tagged for analytic reporting.

## Description
One row in this table represents a single configuration rule that dictates when and how an analytic plan should be applied to a business process. As a staging table, it serves as a raw, direct copy of the Odoo configuration record, intended for use in downstream transformation pipelines to build analytic accounting dimensions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `account_analytic_applicability_id_seq`. |
| analytic_plan_id | INTEGER | true | Foreign key to the analytic plan | Links to the specific analytic plan being applied. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization scope for this rule. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| business_domain | VARCHAR | false | Business domain scope | Defines the functional area (e.g., 'invoice', 'sale'). |
| applicability | VARCHAR | false | Applicability mode | Defines the logic for applying the analytic plan. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp of initial insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| product_categ_id | INTEGER | true | Foreign key to product category | Filters the rule by product category. |
| account_prefix | VARCHAR | true | Account prefix filter | Filters the rule by general ledger account prefix. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `analytic_plan_id` → `account_analytic_plan.id` (Guess: standard Odoo naming for analytic plans).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo user tracking).
    - `product_categ_id` → `product_category.id` (Guess: standard Odoo product hierarchy).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted.
- **Data Integrity:** `analytic_plan_id` and `company_id` are nullable, which may imply global rules or legacy data configurations.
- **Sensitivity:** Contains no PII, but reflects internal financial configuration logic.