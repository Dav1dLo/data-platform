# res_currency

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention (`res_currency`), the use of `create_uid`/`write_uid` audit columns, and the specific sequence-based default value for the primary key.

## Functional process 
This table supports the multi-currency management process within the ERP. It acts as the master reference for all currencies supported by the system, defining their display symbols, rounding rules, and ISO numeric codes used for financial reporting and transaction processing.

## Description
One row in this table represents a single currency definition available for use within the platform. It serves as a raw landed reference entity in the staging layer, providing the metadata required to format and calculate monetary values across the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_currency_id_seq`. |
| name | VARCHAR | false | Currency name | Human-readable name (e.g., 'Euro'). |
| symbol | VARCHAR | false | Currency symbol | The display symbol (e.g., '$', '€'). |
| iso_numeric | INTEGER | true | ISO 4217 numeric code | Three-digit numeric currency code. |
| decimal_places | INTEGER | true | Precision | Number of decimal places for the currency. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the record. |
| full_name | VARCHAR | true | Full currency name | Descriptive name. |
| position | VARCHAR | true | Symbol position | Indicates if symbol is 'before' or 'after' the amount. |
| currency_unit_label | JSONB | true | Unit label | Localized labels for the currency unit. |
| currency_subunit_label | JSONB | true | Subunit label | Localized labels for the currency subunit (e.g., 'cents'). |
| rounding | NUMERIC | true | Rounding factor | The factor used for rounding calculations. |
| active | BOOLEAN | true | Soft-delete flag | If false, the currency is hidden from UI/selection. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `name` (Assuming unique currency names within the system).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure your queries filter by `WHERE active = TRUE` unless you intend to include historical/deactivated currencies.
- **Timestamps:** Timestamps are stored in the system's local time (typically UTC in Odoo environments), but verify against your specific instance configuration.
- **JSONB:** The `currency_unit_label` and `currency_subunit_label` columns contain JSONB data; use PostgreSQL `->>` operators to extract specific language keys if needed.
- **Precision:** The `rounding` column is critical for financial calculations; ensure it is applied consistently with the `decimal_places` column.