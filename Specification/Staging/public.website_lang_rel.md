# website_lang_rel

## Source system
The table likely originates from a Content Management System (CMS) or a multi-lingual e-commerce platform database. The naming convention `_rel` strongly suggests a junction table used to manage many-to-many relationships between website instances and supported language configurations.

## Functional process 
This table supports the localization and internationalization (i18n) configuration process. It defines which languages are enabled or associated with specific website entities, ensuring that content delivery systems can filter or serve the correct language versions based on the `website_id`.

## Description
One row in this table represents a single association between a specific website and a supported language. As a staging table, it serves as a raw, normalized link entity representing the intersection of the website and language domains.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| website_id | INTEGER | false | Foreign key to the website entity | Represents the unique identifier of the website. |
| lang_id | INTEGER | false | Foreign key to the language entity | Represents the unique identifier of the supported language. |

## Keys

- **Primary key (inferred):** The composite key `(website_id, lang_id)`.
- **Foreign keys (inferred):** 
    - `website_id` → `websites.id`: Guessed based on the standard naming convention for website identifiers.
    - `lang_id` → `languages.id`: Guessed based on the standard naming convention for language identifiers.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only relationship identifiers.
- There are no timestamps or audit columns present, so incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that joins to parent tables handle potential orphaned records if referential integrity is not strictly enforced at the source.