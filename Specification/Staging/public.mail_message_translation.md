# mail_message_translation

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of the primary key sequence (`mail_message_translation_id_seq`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific table structure used for managing multi-language content within the Odoo `mail` module.

## Functional process 
This table supports the internationalization (i18n) of communication templates and message content within the platform. It stores translated versions of message bodies, allowing the system to serve localized content to users based on their language preferences, linking specific translations back to a master message record.

## Description
One row in this table represents a single translated version of a message body for a specific target language. It serves as a raw landing copy of the translation repository, capturing the mapping between a source message and its localized text content.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_message_translation_id_seq`. |
| message_id | INTEGER | false | Foreign key to the parent message | Links to the master message record. |
| create_uid | INTEGER | true | User ID who created the translation | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the translation | References the `res_users` table. |
| source_lang | VARCHAR | false | Source language code | e.g., 'en_US'. |
| target_lang | VARCHAR | false | Target language code | e.g., 'fr_FR'. |
| body | TEXT | false | The translated message content | Contains the localized text. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id`: This column links the translation to the base message record.
    - `create_uid` → `res_users.id`: Tracks the user who performed the initial translation creation.
    - `write_uid` → `res_users.id`: Tracks the user who last modified the translation.
- **Natural keys (inferred):** 
    - `(message_id, target_lang)`: A message typically has only one translation per target language.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** The `body` column may contain PII or sensitive communication content depending on the nature of the messages being translated.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed via hard delete if no longer required.
- **Integrity:** As a staging table, ensure that `message_id` exists in the corresponding `mail_message` table before performing joins, as referential integrity may not be strictly enforced at the database level in the staging layer.