# account_incoterms

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `JSONB` for localized fields and a sequence-based `id`, is characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the logistics and supply chain management process by defining International Commercial Terms (Incoterms). These codes dictate the responsibilities of buyers and sellers regarding shipping, insurance, and customs clearance, and are referenced during the sales order and procurement lifecycle.

## Description
One row in this table represents a single Incoterm definition (e.g., FOB, CIF, EXW) used within the organization's logistics configuration. This is a raw landing copy of the source system's configuration table, intended to provide reference data for downstream shipping and order processing entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.account_incoterms_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| code | VARCHAR(3) | false | Standard Incoterm code | Typically 3-character ISO-standard codes. |
| name | JSONB | false | Localized name of the Incoterm | Stores multi-language labels for the term. |
| active | BOOLEAN | true | Soft-delete flag | If false, the term is deprecated or disabled. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit tracking).
- **Natural keys (inferred):** 
    - `code`: The 3-character Incoterm code is the business-level unique identifier for these terms.

## Caveats for downstream consumers

- **Localization:** The `name` column is `JSONB`; queries should use the `->>` operator to extract the relevant language string (e.g., `name->>'en_US'`).
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Ensure queries filter by `WHERE active = TRUE` unless historical data is specifically required.
- **Timestamps:** All timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **PII:** This table contains configuration data and does not contain PII.