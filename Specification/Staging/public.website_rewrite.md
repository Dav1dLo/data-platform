# website_rewrite

## Source system
The table likely originates from an Odoo ERP or a similar web-content management system. The presence of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, alongside the sequence-based primary key, is highly characteristic of Odoo's internal ORM structure for managing URL redirection rules.

## Functional process 
This table supports the web content management and SEO redirection process. It stores rules for mapping legacy or alternative URLs (`url_from`) to current destination URLs (`url_to`) for specific websites, allowing administrators to manage site traffic and handle broken links or site migrations.

## Description
One row in this table represents a single URL rewrite or redirection rule applied to a specific website. It functions as a raw landed copy of the redirection configuration, capturing the source path, destination path, and the status of the rule. The grain is one row per redirection rule definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `website_rewrite_id_seq` |
| website_id | INTEGER | true | Foreign key to the website | Links to the parent website entity |
| route_id | INTEGER | true | Foreign key to the route | Links to a specific site route |
| sequence | INTEGER | true | Execution order | Lower numbers typically processed first |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the rule |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the rule |
| name | VARCHAR | false | Rule name or description | Human-readable label for the rule |
| url_from | VARCHAR | true | Source URL path | The incoming URL pattern to be redirected |
| url_to | VARCHAR | true | Destination URL path | The target URL path |
| redirect_type | VARCHAR | true | HTTP redirect status | e.g., 301 (permanent) or 302 (temporary) |
| active | BOOLEAN | true | Soft-delete flag | If false, the rule is ignored by the system |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: links to a website configuration table)
    - `route_id` → `route.id` (Guess: links to a specific site route definition)
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking)
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` to retrieve only currently enabled redirection rules.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Sensitivity:** No direct PII is present, but `create_uid` and `write_uid` link to internal system users.
- **Data Quality:** `url_from` and `url_to` may contain relative or absolute paths; ensure consistent parsing logic when building join keys or URL validation logic.