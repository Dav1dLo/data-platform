# crm_lead_scoring_frequency_field

## Source system
This table likely originates from an Odoo ERP or CRM system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for primary keys, is highly characteristic of the Odoo framework's internal audit and tracking pattern.

## Functional process 
This table supports the lead scoring configuration process within the CRM. It appears to track which specific fields are included in the frequency calculation for lead scoring models, allowing the system to determine how often or in what context specific lead attributes are evaluated.

## Description
One row in this table represents the association between a specific field and a lead scoring frequency configuration. As a staging table, it serves as a raw, direct landing of the operational database's configuration records, intended for use in downstream transformation pipelines to build analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence for auto-incrementing values. |
| field_id | INTEGER | false | Foreign key to the field definition | Identifies the specific CRM field being tracked. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user table. |
| create_date | TIMESTAMP | true | Creation timestamp | Likely in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id` (guess): This column typically links to the Odoo metadata table defining system fields.
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names; no direct PII is present in this table.
- **Data Integrity:** As a staging table, it may contain orphaned records if the source system does not enforce strict referential integrity at the database level.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted` flag; assume all records are current unless filtered by `write_date`.