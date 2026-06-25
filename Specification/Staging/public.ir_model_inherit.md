# ir_model_inherit

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_inherit` is a standard internal table used by the Odoo framework to manage the inheritance hierarchy of database models (objects).

## Functional process 
This table supports the Odoo ORM's model inheritance mechanism. It tracks how different data models extend or inherit from one another, allowing the system to resolve field dependencies and database schema structures across modular applications.

## Description
One row in this table represents a single inheritance relationship between two models, where a child model inherits properties from a parent model. As a staging table, it provides a raw, direct reflection of the Odoo internal metadata repository, capturing the structural links between system entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by a sequence `ir_model_inherit_id_seq`. |
| model_id | INTEGER | false | Foreign key to the child model | References the model that is inheriting. |
| parent_id | INTEGER | false | Foreign key to the parent model | References the model being inherited from. |
| parent_field_id | INTEGER | true | Foreign key to the field definition | Optional reference to the specific field that triggers the inheritance. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id`: Represents the child entity in the inheritance chain.
    - `parent_id` → `ir_model.id`: Represents the parent entity in the inheritance chain.
    - `parent_field_id` → `ir_model_fields.id`: Specifies the field linking the two models (guess based on Odoo schema patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains internal system metadata; it does not contain business transaction data.
- Timestamps are not present in this table; it represents the current state of the model hierarchy.
- The `parent_field_id` may be null if the inheritance is a standard model extension rather than a field-specific link.
- Queries should be joined against `ir_model` to resolve the human-readable names of the models involved in the inheritance.