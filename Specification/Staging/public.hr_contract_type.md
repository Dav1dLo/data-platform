# hr_contract_type

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `JSONB` for localized fields like `name`, and the sequence-based primary key pattern.

## Functional process 
This table supports the Human Resources management module, specifically defining the various types of employment contracts (e.g., permanent, temporary, internship) available within the organization. It is used to categorize employee records and drive payroll or compliance logic based on the contract type.

## Description
One row in this table represents a single definition of an employment contract type available for assignment to employees. As a staging table, it serves as a raw, direct reflection of the Odoo `hr.contract.type` model, capturing the metadata and configuration for contract classifications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `hr_contract_type_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort types in the UI. |
| country_id | INTEGER | true | Foreign key to country | Links contract type to a specific jurisdiction. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| code | VARCHAR | true | Internal short code | Unique identifier used in business logic. |
| name | JSONB | false | Contract type label | Multilingual name stored as a JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `country_id` → `res_country.id` (Guess: standard Odoo pattern for country-specific configurations).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail for record modification).
- **Natural keys (inferred):** 
    - `code` (Assuming this is the unique business identifier for the contract type).

## Caveats for downstream consumers

- The `name` column is a `JSONB` object; you will likely need to extract the specific language key (e.g., `name->>'en_US'`) for reporting.
- Timestamps (`create_date`, `write_date`) are stored in UTC.
- This table does not appear to implement soft deletes; it reflects the current state of the Odoo configuration.
- `create_uid` and `write_uid` refer to internal system user IDs and may not map to an external HRIS or Active Directory identity without joining to the `res_users` table.