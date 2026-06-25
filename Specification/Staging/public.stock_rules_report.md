# stock_rules_report

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `product_tmpl_id`, `create_uid`, and `write_uid`, combined with the use of PostgreSQL sequences for primary keys, is characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports inventory management and supply chain automation processes. It tracks the configuration of stock rules applied to products or product templates, likely determining how replenishment or procurement logic is triggered within the warehouse management module.

## Description
One row in this table represents a specific stock rule configuration associated with a product or a product template. As a staging table, it serves as a raw, direct copy of the operational database record, capturing the metadata and configuration flags required to drive inventory replenishment logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `stock_rules_report_id_seq`. |
| product_id | INTEGER | false | Foreign key to the specific product | Links to the product variant table. |
| product_tmpl_id | INTEGER | false | Foreign key to the product template | Links to the base product definition. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| product_has_variants | BOOLEAN | false | Flag indicating if product has variants | Determines if the rule applies to a specific variant or the template. |
| create_date | TIMESTAMP | true | Record creation timestamp | Typically stored in UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Typically stored in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product.id` (Guess: links to the specific product variant).
    - `product_tmpl_id` → `product_template.id` (Guess: links to the master product template).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- This table does not appear to implement soft deletes; records are likely updated in place.
- `product_id` and `product_tmpl_id` are both present; ensure your join logic accounts for whether the rule is variant-specific or template-wide based on the `product_has_variants` flag.
- No PII is present in this table, though `create_uid` and `write_uid` link to internal user identities.