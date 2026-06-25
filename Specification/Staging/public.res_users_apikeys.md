# res_users_apikeys

## Source system
This table originates from an Odoo ERP system, as indicated by the `res_users` naming convention, which is the standard schema for user management in Odoo, and the use of Postgres sequence-based primary keys.

## Functional process 
This table supports the authentication and security management process, specifically tracking API keys generated for users to access the system via external integrations or headless services. It manages the lifecycle, scope, and expiration of these programmatic access tokens.

## Description
One row in this table represents a single API key assigned to a specific user account. It serves as a raw landing copy of the security credentials table, capturing the metadata required to validate and authorize API requests within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `res_users_apikeys_id_seq`. |
| name | VARCHAR | false | Display name of the API key | Usually a descriptive label for the integration. |
| user_id | INTEGER | false | Foreign key to the user | Links to the owner of the API key. |
| scope | VARCHAR | true | Permission scope | Defines the access level of the key. |
| expiration_date | TIMESTAMP | true | Expiration timestamp | Null if the key does not expire. |
| index | VARCHAR(8) | true | Key index/prefix | Often used for fast lookups or key identification. |
| key | VARCHAR | true | Hashed or masked API key | Sensitive data; likely a hash rather than the raw secret. |
| create_date | TIMESTAMP | true | Record creation timestamp | Defaults to UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id`: This column links the API key to the specific user account that owns it.
- **Natural keys (inferred):** 
    - `index`: The 8-character index is typically used as a unique identifier for the key in the source system.

## Caveats for downstream consumers

- **Sensitive Data:** The `key` column contains security credentials. Ensure this column is masked or restricted in downstream environments.
- **Timezone:** `create_date` is stored in UTC. `expiration_date` should be assumed to be in UTC unless otherwise specified by the source system configuration.
- **Data Integrity:** This is a staging table; it may contain records that have been deleted in the source system if the ingestion process does not perform hard deletes.
- **Nullability:** `scope` and `expiration_date` are nullable, implying that some keys may have global access or never expire.