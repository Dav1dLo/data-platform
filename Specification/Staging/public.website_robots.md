# website_robots

## Source system
The table likely originates from an Odoo ERP or a similar Python-based web framework application. The naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` is highly characteristic of Odoo's ORM audit fields, and the use of `nextval` on a sequence for the `id` column is standard for PostgreSQL-backed Odoo installations.

## Functional process 
This table supports the management of website configuration, specifically the `robots.txt` file content for web properties. It tracks the administrative users who created or modified the robot exclusion protocol settings and maintains the actual text content used to instruct web crawlers.

## Description
One row in this table represents a specific version or configuration entry of a website's `robots.txt` file. It serves as a raw landing copy of the configuration data, capturing the content and the audit trail of administrative changes within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `website_robots_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| content | TEXT | true | The raw text of the robots.txt file | Contains directives for web crawlers. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Audit fields:** `create_uid` and `write_uid` are likely internal system IDs; they will not resolve to human-readable names without joining to a user metadata table.
- **Data volatility:** As a staging table, this may contain historical versions of the `robots.txt` content if the source system performs updates rather than overwrites.
- **Sensitivity:** No PII is expected in this table, as it contains public-facing web crawler instructions.