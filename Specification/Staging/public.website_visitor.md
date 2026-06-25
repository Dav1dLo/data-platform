# website_visitor

## Source system
The table likely originates from an Odoo ERP or a similar modular business application, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on `website_visitor_id_seq`).

## Functional process 
This table supports the web analytics and visitor tracking process within the platform. It tracks individual visitor sessions or profiles across different websites and partner portals, capturing engagement metrics like `visit_count` and localization preferences such as `country_id` and `lang_id`.

## Description
One row in this table represents a unique visitor profile associated with a specific website or partner portal. It serves as a raw landed staging entity, capturing the visitor's interaction history, localization settings, and authentication tokens for session management.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `website_visitor_id_seq`. |
| website_id | INTEGER | true | Foreign key to the website | Identifies the specific site visited. |
| partner_id | INTEGER | true | Foreign key to the partner | Links the visitor to a registered partner/customer. |
| country_id | INTEGER | true | Foreign key to country | Geographic location of the visitor. |
| lang_id | INTEGER | true | Foreign key to language | Preferred language of the visitor. |
| visit_count | INTEGER | true | Total visit frequency | Counter for sessions associated with this profile. |
| create_uid | INTEGER | true | Creator user ID | ID of the system user who created this record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the system user who last modified this record. |
| access_token | VARCHAR | false | Unique session/access token | Used for secure identification of the visitor. |
| timezone | VARCHAR | true | Visitor timezone | IANA timezone string (e.g., 'UTC'). |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of initial record insertion. |
| last_connection_datetime | TIMESTAMP | true | Last activity timestamp | The most recent interaction time. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (guess: standard Odoo-style naming)
    - `partner_id` → `res_partner.id` (guess: standard Odoo-style naming)
    - `country_id` → `res_country.id` (guess: standard Odoo-style naming)
    - `lang_id` → `res_lang.id` (guess: standard Odoo-style naming)
- **Natural keys (inferred):** `access_token` (likely used to identify the visitor session across requests).

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` should be treated as a sensitive credential and masked in logs or downstream reporting.
- **Timestamps:** Timestamps are assumed to be in UTC, though this should be verified against the source application's configuration.
- **Data Integrity:** `website_id`, `partner_id`, `country_id`, and `lang_id` are nullable, suggesting that visitor profiles may exist without being linked to a specific partner or geographic region.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` column; assume all records are currently active unless otherwise specified by business logic.