# sms_template_preview

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of sequence-based primary keys (`nextval`), is highly characteristic of the Odoo ORM framework.

## Functional process 
This table supports the communication and marketing automation module, specifically the previewing of SMS templates before they are sent to recipients. It tracks the generation of template previews associated with specific resources (e.g., a customer or an order) and language settings, facilitating personalized messaging workflows.

## Description
One row in this table represents a single generated preview of an SMS template, linked to a specific template ID and a target resource. As a staging table, it serves as a raw, landed copy of the operational system's preview history, intended for use in downstream transformation pipelines to audit or analyze communication attempts.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sms_template_preview_id_seq`. |
| sms_template_id | INTEGER | false | Foreign key to the SMS template definition | Links to the master template record. |
| create_uid | INTEGER | true | User ID who created the preview | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the preview | References the system user table. |
| lang | VARCHAR | true | Language code for the preview | e.g., 'en_US', 'fr_FR'. |
| resource_ref | VARCHAR | true | Reference to the source object | Often a string like 'res.partner,123'. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed based on standard Odoo patterns. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed based on standard Odoo patterns. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sms_template_id` → `sms_template.id` (Inferred from naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard PostgreSQL/Odoo deployments.
- **Sensitive Data:** The `resource_ref` may contain identifiers that link to sensitive customer data; ensure appropriate access controls are applied.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), so assume all records are current unless otherwise specified by the source system's business logic.
- **Data Integrity:** As a staging table, expect potential duplicates or incomplete records if the ingestion process is interrupted.