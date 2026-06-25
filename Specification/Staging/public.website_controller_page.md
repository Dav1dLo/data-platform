# website_controller_page

## Source system
This table originates from an Odoo ERP or a similar Python-based web framework system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the use of `nextval` sequences for primary keys, is highly characteristic of the Odoo ORM metadata pattern.

## Functional process 
This table supports the website content management and routing process. It maps specific controller pages to website instances and views, likely managing the configuration of dynamic web pages, URL slugs, and publication status within a multi-site web environment.

## Description
One row in this table represents a single configured web page or controller route within the website management module. It acts as a raw landing copy of the page definition, capturing the relationship between the page name, its associated view, and its publication state.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `website_controller_page_id_seq`. |
| website_id | INTEGER | true | Foreign key to the website | Links to the specific website instance. |
| view_id | INTEGER | false | Foreign key to the view definition | The primary UI template associated with this page. |
| record_view_id | INTEGER | true | Foreign key to a specific record view | Used for dynamic content rendering. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | false | Display name of the page | Human-readable identifier. |
| name_slugified | VARCHAR | true | URL-friendly version of the name | Used for routing and SEO. |
| record_domain | VARCHAR | true | Domain filter for the page | Defines the scope of records visible on this page. |
| default_layout | VARCHAR | true | Layout template identifier | Specifies the default visual structure. |
| is_published | BOOLEAN | true | Publication status flag | Determines if the page is live on the site. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Inferred from naming convention).
    - `view_id` → `ir_ui_view.id` (Inferred from standard Odoo schema patterns).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **Data Integrity:** `website_id` is nullable, which may imply global pages that are not restricted to a specific website instance.
- **Sensitive Data:** No PII is explicitly present, but `create_uid` and `write_uid` link to user identities which should be handled according to internal privacy policies.