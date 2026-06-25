# account_fiscal_position_res_config_settings_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific pairing of `res_config_settings` and `account_fiscal_position` is characteristic of Odoo's many-to-many relationship tables, which are automatically generated to link configuration settings to fiscal position definitions.

## Functional process 
This table supports the configuration of accounting modules, specifically mapping fiscal positions (which define tax and account mapping rules) to specific configuration settings. It facilitates the association between global system settings and the fiscal rules applied during transaction processing.

## Description
One row in this table represents a single link between a configuration setting record and a fiscal position record. It acts as a join table in the staging layer, providing a raw, normalized view of the many-to-many relationship as it exists in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_config_settings_id | INTEGER | false | Foreign key to the configuration settings table | Links to the parent configuration record. |
| account_fiscal_position_id | INTEGER | false | Foreign key to the fiscal position table | Links to the specific fiscal position definition. |

## Keys

- **Primary key (inferred):** The combination of `res_config_settings_id` and `account_fiscal_position_id`.
- **Foreign keys (inferred):**
    - `res_config_settings_id` → `res_config_settings.id`: This column references the primary key of the configuration settings table.
    - `account_fiscal_position_id` → `account_fiscal_position.id`: This column references the primary key of the fiscal position table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only the relationship identifiers.
- There is no audit timestamp or soft-delete flag present; assume this reflects the current state of the relationship as captured during the last ingestion.
- Ensure joins to parent tables are handled as inner joins if you require complete records, as these IDs are mandatory.