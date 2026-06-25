# product_attr_exclusion_value_ids_rel

## Source system
This table likely originates from an Odoo ERP or a similar modular e-commerce/inventory system. The naming convention `product_template_attribute_exclusion_id` is highly characteristic of Odoo's relational mapping for product configuration constraints.

## Functional process 
This table supports the product configuration and variant management process. It acts as a bridge table to define specific attribute value combinations that are mutually exclusive for a given product template, preventing invalid product configurations (e.g., a specific color that cannot be paired with a specific material).

## Description
Each row represents a single association between a product attribute exclusion rule and a specific attribute value that is part of that exclusion. This is a junction table used to resolve a many-to-many relationship between exclusion definitions and attribute values. It serves as a raw landed copy of the relational mapping from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_attribute_exclusion_id | INTEGER | false | Foreign key to the exclusion rule definition. | Links to the parent exclusion record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the specific attribute value. | Represents the value involved in the exclusion. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of both columns.
- **Foreign keys (inferred):** 
    - `product_template_attribute_exclusion_id` → `product_template_attribute_exclusion.id` (Guess: links to the primary exclusion rule entity).
    - `product_template_attribute_value_id` → `product_template_attribute_value.id` (Guess: links to the specific attribute value definition).
- **Natural keys (inferred):** The combination of `(product_template_attribute_exclusion_id, product_template_attribute_value_id)` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this represents the current state of the source system's configuration.
- Queries should perform `INNER JOIN` operations against the parent tables to retrieve human-readable names for the exclusions and values.