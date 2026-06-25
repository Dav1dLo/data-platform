# stock_putaway_rule

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_date`, `company_id`) and the specific sequence of columns are characteristic of Odoo's internal ORM structure for inventory management modules.

## Functional process 
This table supports the warehouse inventory management process, specifically the "Putaway Strategy" logic. It defines the rules that determine where incoming products should be automatically routed (from an input location to a specific storage location) based on product attributes, categories, or storage categories.

## Description
One row in this table represents a single putaway rule configuration that dictates the movement of stock from an incoming location to a destination location. As a staging table, it provides a raw, direct copy of the configuration records from the source ERP. It is used to drive automated warehouse replenishment and stock placement workflows.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `stock_putaway_rule_id_seq`. |
| product_id | INTEGER | true | Foreign key to the product | Identifies the specific product this rule applies to. |
| category_id | INTEGER | true | Foreign key to product category | Applies the rule to a group of products. |
| location_in_id | INTEGER | false | Foreign key to source location | The location where the product arrives. |
| location_out_id | INTEGER | false | Foreign key to destination location | The target location for the putaway. |
| sequence | INTEGER | true | Priority order | Lower numbers indicate higher priority rules. |
| company_id | INTEGER | false | Foreign key to company | Multi-tenant identifier for the organization. |
| storage_category_id | INTEGER | true | Foreign key to storage category | Links to specific storage capacity/type rules. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the rule. |
| sublocation | VARCHAR | true | Sub-location identifier | Specific aisle, rack, or bin detail. |
| active | BOOLEAN | true | Soft-delete flag | If false, the rule is ignored by the system. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: links to the product master data)
    - `category_id` → `product_category.id` (Guess: links to the product category hierarchy)
    - `location_in_id` → `stock_location.id` (Guess: links to the warehouse location registry)
    - `location_out_id` → `stock_location.id` (Guess: links to the warehouse location registry)
    - `company_id` → `res_company.id` (Guess: links to the organization entity)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` to retrieve only current, valid rules.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Nullability:** Many fields (like `product_id` or `category_id`) are nullable because a rule might apply to a whole category, a specific product, or a storage category, rather than all simultaneously.
- **Sensitivity:** No direct PII is present, but `create_uid` and `write_uid` link to internal system users.