# ir_model_fields

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_model_fields` (Internal Registry Model Fields) is a core component of the Odoo ORM metadata layer, which manages the dynamic definition of database models and their associated fields.

## Functional process 
This table supports the Odoo ORM's dynamic schema management and metadata introspection. It defines the structure of data models within the application, including field types, relationships, constraints, and UI-related properties, allowing the system to generate database schemas and user interfaces dynamically.

## Description
One row in this table represents a single field definition for a specific data model within the Odoo environment. It captures the technical configuration of the field, such as its data type, relationship properties, and behavioral flags. As a staging table, it provides a raw, comprehensive snapshot of the system's internal metadata registry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| relation_field_id | INTEGER | true | ID of the related field | Used for M2M/O2M relationship mapping. |
| model_id | INTEGER | false | ID of the parent model | References `ir_model`. |
| related_field_id | INTEGER | true | ID of the related field | Used for related field definitions. |
| size | INTEGER | true | Field size constraint | Often used for char fields. |
| create_uid | INTEGER | true | Creator user ID | References `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | References `res_users`. |
| name | VARCHAR | false | Technical field name | The programmatic identifier. |
| complete_name | VARCHAR | true | Fully qualified name | Usually `model.field`. |
| model | VARCHAR | false | Model technical name | The model this field belongs to. |
| relation | VARCHAR | true | Target model name | For relational fields (M2O, M2M). |
| relation_field | VARCHAR | true | Inverse field name | Used in relational mappings. |
| ttype | VARCHAR | false | Field data type | e.g., char, integer, many2one. |
| related | VARCHAR | true | Related field path | Dot-notation path to a related value. |
| state | VARCHAR | false | Field state | e.g., 'base' (system) or 'manual' (custom). |
| on_delete | VARCHAR | true | Delete behavior | e.g., 'cascade', 'set null'. |
| domain | VARCHAR | true | Filter domain | Search/selection criteria. |
| relation_table | VARCHAR | true | M2M join table name | Used for many-to-many relations. |
| column1 | VARCHAR | true | M2M join column 1 | Source side of join. |
| column2 | VARCHAR | true | M2M join column 2 | Target side of join. |
| depends | VARCHAR | true | Dependency list | Fields triggering recompute. |
| currency_field | VARCHAR | true | Currency field name | Used for monetary fields. |
| field_description | JSONB | false | Field label | Multi-language support via JSON. |
| help | JSONB | true | Tooltip text | Multi-language support via JSON. |
| compute | TEXT | true | Compute method code | Python logic for calculated fields. |
| copied | BOOLEAN | true | Copy flag | Whether field is included in record copy. |
| required | BOOLEAN | true | Required constraint | Not null constraint. |
| readonly | BOOLEAN | true | Read-only flag | UI/ORM write restriction. |
| index | BOOLEAN | true | Index flag | Whether to create a DB index. |
| translate | BOOLEAN | true | Translation flag | Whether field is translatable. |
| company_dependent | BOOLEAN | true | Multi-company flag | Whether value varies by company. |
| group_expand | BOOLEAN | true | Group expand flag | Used in Kanban/list views. |
| selectable | BOOLEAN | true | Selectable flag | Whether field is searchable. |
| store | BOOLEAN | true | Stored flag | Whether field is persisted in DB. |
| sanitize | BOOLEAN | true | Sanitize flag | HTML sanitization. |
| sanitize_overridable | BOOLEAN | true | Override flag | Sanitization override. |
| sanitize_tags | BOOLEAN | true | Tag sanitization | HTML tag filtering. |
| sanitize_attributes | BOOLEAN | true | Attribute sanitization | HTML attribute filtering. |
| sanitize_style | BOOLEAN | true | Style sanitization | HTML style filtering. |
| sanitize_form | BOOLEAN | true | Form sanitization | HTML form filtering. |
| strip_style | BOOLEAN | true | Strip style flag | HTML cleanup. |
| strip_classes | BOOLEAN | true | Strip classes flag | HTML cleanup. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC. |
| write_date | TIMESTAMP | true | Modification timestamp | UTC. |
| tracking | INTEGER | true | Tracking level | Audit trail configuration. |
| website_form_blacklisted | BOOLEAN | true | Blacklist flag | Website form exposure control. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id` (Inferred from Odoo architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** 
    - `model`, `name` (The combination of model technical name and field technical name is unique).

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **JSONB:** `field_description` and `help` contain JSON objects; ensure your query dialect supports JSONB extraction if you need to parse these.
- **Computed Fields:** Fields where `store` is `false` may not exist as physical columns in the target model's table; they are calculated on-the-fly by the ORM.
- **Soft Deletes:** This table does not implement soft deletes; it reflects the current state of the Odoo metadata registry.