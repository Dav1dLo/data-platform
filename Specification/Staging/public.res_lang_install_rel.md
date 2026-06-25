# res_lang_install_rel

## Source system
This table originates from an Odoo ERP system, as indicated by the `res_` prefix (common in Odoo's `res` module for resources) and the `_rel` suffix, which is the standard naming convention for many-to-many join tables in the Odoo ORM.

## Functional process 
This table supports the language configuration and localization management process. It acts as a link table between a language installation wizard session and the specific languages selected or installed during that process.

## Description
One row in this table represents a single association between a language installation wizard instance and a specific language ID. It serves as a raw landing copy of the many-to-many relationship table used to track which languages are associated with which installation tasks.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| language_wizard_id | INTEGER | false | Foreign key to the language installation wizard session. | Part of the composite primary key. |
| lang_id | INTEGER | false | Foreign key to the language definition table. | Part of the composite primary key. |

## Keys

- **Primary key (inferred):** `(language_wizard_id, lang_id)`
- **Foreign keys (inferred):** 
    - `language_wizard_id → base_language_install.id`: This column links to the wizard session that manages the installation process.
    - `lang_id → res_lang.id`: This column links to the master list of languages defined in the system.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns; assume this table is truncated and reloaded or managed via Odoo's ORM logic.
- As a staging table, it should be joined with the corresponding master tables (`res_lang`) to retrieve human-readable language names or codes.