# base_language_install

## Source system
The table likely originates from an Odoo ERP system. The naming convention (`base_language_install`), the presence of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific sequence-based default for the `id` column are characteristic patterns of Odoo's ORM layer.

## Functional process 
This table supports the localization and internationalization process within the ERP. It tracks which language packs have been installed or updated in the system, allowing the application to manage multi-language user interfaces and document translations.

## Description
One row represents a single language installation or update event within the application environment. This is a raw staging table containing metadata about language configuration changes, serving as a record of which languages are active or have been modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| overwrite | BOOLEAN | true | Flag indicating if existing translations were overwritten | Used during language pack updates. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit columns:** `create_uid` and `write_uid` are likely internal system IDs; ensure joins to the user dimension are handled via outer joins if user records have been purged.
- **Data volatility:** As a staging table, this may contain multiple entries for the same language if the `overwrite` process creates new records rather than updating existing ones.
- **Sensitivity:** No PII is present in this table; it contains only system configuration and audit metadata.