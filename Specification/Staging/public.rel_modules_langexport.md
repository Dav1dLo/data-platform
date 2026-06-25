# rel_modules_langexport

## Source system
Unknown — insufficient evidence. The table name suggests a relationship mapping between modules and language exports, but the naming convention does not align with common enterprise ERP or CRM systems.

## Functional process 
This table supports a localization or content management process, likely mapping specific software or training modules to their respective language export configurations. It acts as a bridge table to manage many-to-many relationships between module definitions and language-specific export settings.

## Description
One row in this table represents a single association between a module and a language export configuration. It is a raw landed staging table used to maintain referential integrity between module entities and their associated language-specific data exports.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wiz_id | INTEGER | false | Identifier for the language export configuration | Likely a surrogate key from the source system. |
| module_id | INTEGER | false | Identifier for the module | Represents the entity being exported. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table appears to be a join table; a composite primary key on `(wiz_id, module_id)` is likely.
- **Foreign keys (inferred):** 
    - `wiz_id` → `lang_exports.id` (guess: links to the configuration definition).
    - `module_id` → `modules.id` (guess: links to the primary module entity).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a join table; expect many-to-many relationships.
- No audit timestamps or soft-delete flags are present, suggesting this is a snapshot or a direct dump of a link table.
- Ensure inner joins are used if you only require records with valid associations, as this table contains no descriptive attributes.