# website_page_properties_base

## Source system
The table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, combined with the use of `nextval` sequences for the primary key, is a hallmark of the Odoo framework's ORM metadata pattern.

## Functional process 
This table supports the website content management and routing process. It tracks the configuration and metadata for specific pages or URL endpoints within a web portal, linking them to specific target models (likely content types or database entities) and tracking the administrative users responsible for their creation and modification.

## Description
One row represents the configuration properties and metadata for a single website page or URL route. As a staging table, it serves as a raw, landed copy of the source system's page property definitions, maintaining the grain of one row per unique page configuration record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| website_id | INTEGER | false | Foreign key to the website entity | Identifies which website instance the page belongs to. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| target_model_id | VARCHAR | false | Target model identifier | The internal system name of the model associated with this page. |
| url | VARCHAR | false | Page URL path | The relative path or full URL string for the page. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: standard Odoo-style naming convention for multi-site setups).
    - `create_uid` → `res_users.id` (Guess: standard Odoo-style audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo-style audit field).
- **Natural keys (inferred):** 
    - `url` (Assuming unique constraints on URL paths within a specific `website_id`).

## Caveats for downstream consumers

- **PII/Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may link to employee or user names in other tables.
- **Timestamps:** Assumed to be in UTC; verify against the source system's timezone configuration if precision is required for audit logs.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records present are currently active in the source system.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the source system's ETL process is interrupted.