# snailmail_letter_missing_required_fields

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in Odoo, along with the use of a PostgreSQL sequence for the primary key.

## Functional process 
This table supports the physical mailing process by tracking records where required address fields are missing for snail mail letters. It acts as an exception or validation log, likely used to identify letters that cannot be dispatched due to incomplete address data (e.g., missing street, zip, or city) associated with a specific partner or letter entity.

## Description
One row in this table represents a specific instance of a snail mail letter that failed validation due to missing required address fields. It serves as a raw landing copy of the exception state, capturing the incomplete address components and the associated partner or letter identifiers at the time of the validation failure.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a PostgreSQL sequence. |
| partner_id | INTEGER | true | Foreign key to the partner | Likely references the `res_partner` table. |
| letter_id | INTEGER | true | Foreign key to the letter | Likely references the `snailmail_letter` table. |
| state_id | INTEGER | true | Foreign key to the state/province | Likely references the `res_country_state` table. |
| country_id | INTEGER | true | Foreign key to the country | Likely references the `res_country` table. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| street | VARCHAR | true | Street address line 1 | |
| street2 | VARCHAR | true | Street address line 2 | |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo naming convention for partner references).
    - `letter_id` → `snailmail_letter.id` (Standard Odoo naming convention for letter references).
    - `state_id` → `res_country_state.id` (Standard Odoo naming convention for state references).
    - `country_id` → `res_country.id` (Standard Odoo naming convention for country references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- This table contains address information (`street`, `city`, `zip`) which may be considered PII depending on local data privacy regulations.
- The table tracks "missing" fields, so expect high nullability in address-related columns.
- There is no explicit soft-delete flag; assume records are either active or represent a point-in-time validation failure.