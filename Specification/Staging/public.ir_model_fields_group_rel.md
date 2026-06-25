# ir_model_fields_group_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_model_fields_group_rel` is characteristic of Odoo's internal metadata tables, specifically those managing many-to-many relationships between fields (`ir.model.fields`) and user groups (`res.groups`) for access control purposes.

## Functional process 
This table supports the security and access control layer of the ERP. It defines which user groups have visibility or edit permissions over specific data fields within the system's models, facilitating field-level security configurations.

## Description
One row in this table represents a single association between a specific data field and a user group. It acts as a join table in the staging layer, providing a raw, normalized link between field definitions and security groups to enable downstream access control filtering.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| field_id | INTEGER | false | Foreign key to the field definition | References the primary key of the field metadata table. |
| group_id | INTEGER | false | Foreign key to the user group | References the primary key of the user group table. |

## Keys

- **Primary key (inferred):** The combination of `(field_id, group_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id`: This column links to the definition of the field being restricted.
    - `group_id` → `res_groups.id`: This column links to the security group granted access.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a high volume of rows representing many-to-many relationships.
- There are no timestamps or audit columns present; it is impossible to determine when these relationships were created or modified from this table alone.
- This table contains no PII, but it governs access to sensitive data; ensure that joins to this table are handled correctly to avoid leaking field-level security configurations.
- The table structure assumes that `field_id` and `group_id` are strictly enforced by the source system's referential integrity.