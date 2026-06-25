# res_users_apikeys_description

## Source system
This table originates from an Odoo ERP system, as evidenced by the `res_users_` prefix and the specific pattern of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are standard audit fields in the Odoo framework.

## Functional process 
This table supports the security and authentication management process, specifically tracking API keys generated for system users. It stores metadata regarding the purpose, lifespan, and expiration of these keys to facilitate secure programmatic access to the ERP.

## Description
Each row represents a unique API key description associated with a user account, defining the key's name, its intended duration, and its expiration timestamp. As a staging table, it serves as a raw, direct reflection of the Odoo `res.users.apikeys.description` model, capturing the lifecycle metadata of authentication tokens.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_users_apikeys_description_id_seq`. |
| create_uid | INTEGER | true | Creator user ID | References the user who generated the API key. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| name | VARCHAR | false | API key label | A descriptive name for the API key. |
| duration | VARCHAR | false | Key validity period | Likely stores a duration string or interval definition. |
| expiration_date | TIMESTAMP | true | Expiration timestamp | The date and time when the API key becomes invalid. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp for when the record was created. |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit timestamp for the last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Likely references the user who created the key.
    - `write_uid` → `res_users.id`: Likely references the user who last modified the key record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`, `expiration_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `duration` column is a `VARCHAR`, suggesting it may contain non-standardized text or interval formats that require parsing before use in date arithmetic.
- This table contains audit fields (`create_uid`, `write_uid`) that link to the internal user directory; ensure appropriate access controls are in place when joining with user-identifiable information.