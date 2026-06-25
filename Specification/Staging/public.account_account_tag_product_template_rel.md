# account_account_tag_product_template_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `product_template` and `account_account_tag` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link product templates to accounting tags.

## Functional process 
This table supports the product-to-accounting classification process. It enables the mapping of specific product templates to accounting tags, which are typically used for financial reporting, tax categorization, or automated journal entry generation based on product attributes.

## Description
One row in this table represents a single association between a product template and an accounting tag. It serves as a raw junction table in the staging layer, facilitating the many-to-many relationship required to categorize products for accounting purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template | References the primary product definition. |
| account_account_tag_id | INTEGER | false | Foreign key to the accounting tag | References the specific tag used for financial grouping. |

## Keys

- **Primary key (inferred):** The composite of (`product_template_id`, `account_account_tag_id`).
- **Foreign keys (inferred):** 
    - `product_template_id` → `product_template.id`: This column links to the master product definition table.
    - `account_account_tag_id` → `account_account_tag.id`: This column links to the accounting tag definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against both the `product_template` and `account_account_tag` tables to retrieve meaningful business names.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification date of these relationships from this table alone.
- The table contains no surrogate primary key, so standard joins should be performed on the composite key.