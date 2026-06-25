# website_snippet_filter

## Source system
The table likely originates from an Odoo ERP or a similar modular web-based business application. This is inferred from the presence of standard Odoo-style audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for localized names, and the specific naming convention of `action_server_id` and `website_id` which are common in Odoo's website and automation modules.

## Functional process 
This table supports the configuration of website content filtering, specifically managing how snippets or dynamic content blocks are filtered before being rendered on a web page. It links specific website instances to server-side actions and filter definitions, determining which data fields are retrieved and the volume of records displayed via the `limit` column.

## Description
Each row represents a specific filter configuration applied to a website snippet, defining the parameters for data retrieval and display. As a staging table, it acts as a raw, direct copy of the operational database's configuration settings, intended for use in downstream reporting or synchronization processes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `website_snippet_filter_id_seq`. |
| website_id | INTEGER | true | Foreign key to the website | Identifies which website this filter configuration belongs to. |
| action_server_id | INTEGER | true | Foreign key to server action | Links to the specific server-side action triggered by this filter. |
| filter_id | INTEGER | true | Foreign key to filter definition | References the underlying filter logic or criteria. |
| limit | INTEGER | false | Record limit | The maximum number of records to return for the snippet. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| field_names | VARCHAR | false | Field selection | Comma-separated list of fields to be retrieved. |
| name | JSONB | false | Display name | Localized name of the filter, stored as a JSON object. |
| is_published | BOOLEAN | true | Publication status | Indicates if the snippet filter is currently active/published. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Likely reference to a website configuration table).
    - `action_server_id` → `ir_actions_server.id` (Standard Odoo reference for server actions).
    - `filter_id` → `ir_filters.id` (Standard Odoo reference for saved filters).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **JSONB:** The `name` column contains JSON data; use PostgreSQL `->>` or `->` operators to extract values (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless `is_published` is explicitly `false`.
- **Data Integrity:** `website_id`, `action_server_id`, and `filter_id` are nullable, suggesting that some filters may be global or not yet linked to specific entities.