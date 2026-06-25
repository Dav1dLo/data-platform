# module_country

## Source system
Unknown — insufficient evidence. The naming convention suggests a mapping table between modules and countries, but the lack of prefixing or specific system-identifying columns makes it impossible to attribute this to a specific operational system like SAP or Salesforce.

## Functional process 
This table supports a many-to-many relationship management process, likely defining which software modules, features, or business units are enabled or localized for specific countries. It acts as a bridge table to enforce configuration constraints across regional deployments.

## Description
One row in this table represents a single association between a specific module and a specific country. As a staging table, it serves as a raw landed copy of the relationship mapping, intended to be used for joining module metadata with country-specific configuration data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| module_id | INTEGER | false | Unique identifier for the module | Likely a foreign key to a modules dimension table. |
| country_id | INTEGER | false | Unique identifier for the country | Likely a foreign key to a countries dimension table. |

## Keys

- **Primary key (inferred):** The composite of (`module_id`, `country_id`).
- **Foreign keys (inferred):** 
    - `module_id` → `modules.id` (guess: standard naming convention for module entities).
    - `country_id` → `countries.id` (guess: standard naming convention for country entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a bridge/link table; expect no descriptive attributes, only identifiers.
- Ensure inner joins are used when filtering for active module-country pairings, as the staging layer may contain orphaned IDs if referential integrity is not enforced at the source.
- No soft-delete flags are present; assume this table represents the current state of associations as captured during the last ingestion.