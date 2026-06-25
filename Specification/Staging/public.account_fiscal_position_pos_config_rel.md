# account_fiscal_position_pos_config_rel

## Source system
This table originates from Odoo (OpenERP), as indicated by the naming convention `_rel` (a standard Odoo junction table suffix) and the specific pairing of `pos_config` (Point of Sale configuration) and `account_fiscal_position` (tax mapping rules).

## Functional process 
This table supports the Point of Sale (POS) configuration process by mapping specific fiscal positions to POS configurations. It defines which tax mapping rules (fiscal positions) are active or applicable for a given POS terminal or shop setup, ensuring that the correct tax rates are applied during transaction processing.

## Description
One row in this table represents a many-to-many relationship between a Point of Sale configuration and a fiscal position. It serves as a raw landed link table in the staging layer, facilitating the resolution of tax mapping rules for specific POS environments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary key of the POS configuration table. |
| account_fiscal_position_id | INTEGER | false | Foreign key to the fiscal position | Links to the primary key of the account fiscal position table. |

## Keys

- **Primary key (inferred):** The combination of `(pos_config_id, account_fiscal_position_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column references the configuration entity for the Point of Sale system.
    - `account_fiscal_position_id` → `account_fiscal_position.id`: This column references the tax mapping rule entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table.
- Ensure that joins to the parent tables (`pos_config` and `account_fiscal_position`) are handled as inner joins if you only require valid, active mappings.