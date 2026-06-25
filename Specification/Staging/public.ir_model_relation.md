# ir_model_relation

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_relation` (Internal Record model relation) and the specific sequence pattern `nextval('"public".ir_model_relation_id_seq'::regclass)` are characteristic of Odoo's metadata schema, which manages the relationships between data models and the modules that define them.

## Functional process 
This table supports the Odoo framework's internal registry, specifically tracking the dependency or association between data models and the modules that provide them. It is used by the system to manage module installation, upgrades, and the structural integrity of the ORM (Object-Relational Mapping) layer.

## Description
One row in this table represents a single association between a specific data model and a module within the Odoo environment. This is a raw staging table containing a direct copy of the system's internal registry records, used to track which modules are responsible for which data models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| model | INTEGER | false | Foreign key to the data model | References the `ir_model` table. |
| module | INTEGER | false | Foreign key to the module | References the `ir_module_module` table. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| name | VARCHAR | false | Descriptive name of the relation | Often a technical string identifier. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed based on Odoo standards. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed based on Odoo standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model` → `ir_model.id`: Links the relation to the specific data model definition.
    - `module` → `ir_module_module.id`: Links the relation to the specific module definition.
    - `create_uid` → `res_users.id`: Identifies the user who performed the creation.
    - `write_uid` → `res_users.id`: Identifies the user who performed the last update.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table is a technical system table; changes to these records are typically managed by the Odoo ORM and should not be modified manually.
- The `model` and `module` columns are integer references; ensure joins are performed against the corresponding `ir_model` and `ir_module_module` tables to retrieve human-readable names.