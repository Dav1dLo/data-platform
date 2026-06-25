# calendar_provider_config

## Source system
The table appears to originate from an Odoo ERP or a similar modular business application, evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based primary keys.

## Functional process 
This table supports the integration and synchronization process for external calendar services. It stores the configuration and authentication credentials required to interface with third-party calendar providers, specifically managing the connectivity state and API credentials for services like Microsoft Outlook.

## Description
One row in this table represents a specific configuration profile for an external calendar provider integration. It serves as a raw landing copy of the application's internal settings, capturing the necessary API client identifiers, secrets, and synchronization status flags required to maintain connectivity between the platform and external calendar systems.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `calendar_provider_config_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References an internal user system. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References an internal user system. |
| external_calendar_provider | VARCHAR | true | Name of the calendar service provider | e.g., 'google', 'outlook'. |
| cal_client_id | VARCHAR | true | OAuth client ID for general calendar integration | Sensitive credential. |
| cal_client_secret | VARCHAR | true | OAuth client secret for general calendar integration | Sensitive credential. |
| microsoft_outlook_client_identifier | VARCHAR | true | Specific client ID for Microsoft Outlook | Sensitive credential. |
| microsoft_outlook_client_secret | VARCHAR | true | Specific client secret for Microsoft Outlook | Sensitive credential. |
| cal_sync_paused | BOOLEAN | true | Flag indicating if general sync is paused | True if sync is disabled. |
| microsoft_outlook_sync_paused | BOOLEAN | true | Flag indicating if Outlook sync is paused | True if sync is disabled. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo-style audit link).
    - `write_uid` → `res_users.id` (guess: standard Odoo-style audit link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains `cal_client_secret` and `microsoft_outlook_client_secret`. These columns should be masked or restricted to authorized service accounts only.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard PostgreSQL/Odoo practices.
- **Data Integrity:** As a staging table, this may contain multiple versions of configuration records if the source system performs soft deletes or maintains history via update timestamps.
- **Nullability:** Many configuration fields are nullable; queries should handle potential `NULL` values when checking sync status or provider names.