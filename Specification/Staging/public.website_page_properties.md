# website_page_properties

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` is a standard pattern for Odoo's ORM-managed tables, which track record authorship and modification timestamps.

## Functional process 
This table supports the website management module, specifically tracking metadata and historical URL mappings for web pages. It links specific website content to internal models and tracks the lifecycle of page property updates.

## Description
One row represents a set of properties or configuration metadata associated with a specific website page. It serves as a raw staging entity, capturing the state of page-related attributes and their audit trails as they exist in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `website_page_properties_id_seq`. |
| target_model_id | INTEGER | true | Foreign key to the target model | Likely references a content or page model. |
| website_id | INTEGER | false | Foreign key to the website | Identifies which website instance the page belongs to. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| old_url | INTEGER | true | Previous URL path | Used for tracking URL redirects or historical page paths. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the source system. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Inferred from standard Odoo naming conventions).
    - `create_uid` → `res_users.id` (Inferred from standard Odoo audit column patterns).
    - `write_uid` → `res_users.id` (Inferred from standard Odoo audit column patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user tables; ensure access to user identity data is governed.
- **Timestamps:** Timestamps are assumed to be in the source system's timezone (typically UTC in Odoo).
- **Data Integrity:** `target_model_id` and `old_url` are nullable, suggesting that not all page properties are linked to specific models or have historical URL data.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag; assume all records are current unless otherwise specified by the source system logic.