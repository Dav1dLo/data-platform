# product_pricelist

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`, `JSONB` for translatable fields) and the use of sequence-based primary keys are characteristic of the Odoo framework's underlying PostgreSQL database schema.

## Functional process 
This table supports the pricing and sales management process by defining various price lists used to determine product pricing for different customers, regions, or sales channels. It acts as a configuration entity that links currencies and companies to specific pricing strategies.

## Description
One row in this table represents a single price list configuration record. It serves as a raw landed copy of the Odoo `product.pricelist` model, capturing the metadata and structural definition of a price list rather than the individual product price points themselves.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_pricelist_id_seq` |
| sequence | INTEGER | true | Display order index | Used for UI sorting |
| currency_id | INTEGER | false | Foreign key to currency | Links to the currency definition |
| company_id | INTEGER | true | Foreign key to company | Links to the owning organization |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record |
| name | JSONB | false | Pricelist name | Likely contains multi-language translations |
| active | BOOLEAN | true | Soft-delete flag | If false, the pricelist is archived |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Guess: standard Odoo naming convention for currency links).
    - `company_id` → `res_company.id` (Guess: standard Odoo naming convention for multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail link).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is stored as `JSONB`; queries will need to use the `->>` operator to extract text values (e.g., `name->>'en_US'`).
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's default behavior.
- The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` to retrieve only current records.
- This is a staging table; it may contain raw system artifacts and should be joined with care against other Odoo-derived tables.