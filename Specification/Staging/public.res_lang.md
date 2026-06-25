# res_lang

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `res_lang` (Resource Language) and the presence of audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date` are characteristic of Odoo's core resource models.

## Functional process 
This table supports the localization and internationalization (i18n) process within the ERP. It defines the available languages for the user interface, document generation, and data formatting, ensuring that dates, times, and numeric values are presented according to regional standards.

## Description
One row in this table represents a single language configuration available within the system. It acts as a reference table in the staging layer, providing the necessary metadata for formatting and localization settings. The grain is one row per unique language code.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users`. |
| name | VARCHAR | false | Full name of the language | e.g., "English (US)". |
| code | VARCHAR | false | Language code | e.g., "en_US". |
| iso_code | VARCHAR | true | ISO 639-1/2 language code | Optional standard identifier. |
| url_code | VARCHAR | false | Code used in URL routing | Used for multi-language website paths. |
| direction | VARCHAR | false | Text direction | Usually "ltr" or "rtl". |
| date_format | VARCHAR | false | Date format string | e.g., "%m/%d/%Y". |
| time_format | VARCHAR | false | Time format string | e.g., "%H:%M:%S". |
| short_time_format | VARCHAR | false | Short time format string | e.g., "%H:%M". |
| week_start | VARCHAR | false | First day of the week | Integer or string representation. |
| grouping | VARCHAR | false | Number grouping format | e.g., "[3,0]". |
| decimal_point | VARCHAR | false | Decimal separator character | e.g., ".". |
| thousands_sep | VARCHAR | true | Thousands separator character | e.g., ",". |
| active | BOOLEAN | true | Soft-delete flag | If false, the language is hidden. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `code` (The unique language identifier used by the application).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = true` unless historical audit is required.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Formatting Strings:** The format columns (e.g., `date_format`) use Python-style strftime directives; ensure your downstream transformation logic can parse these.
- **PII/Sensitivity:** This table contains no PII; it is purely configuration data.