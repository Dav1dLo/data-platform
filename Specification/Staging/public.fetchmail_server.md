# fetchmail_server

## Source system
This table originates from an Odoo ERP instance, as evidenced by the characteristic naming conventions (`create_uid`, `write_uid`, `create_date`, `write_date`), the use of `nextval` sequences for primary keys, and the specific module-related prefix `fetchmail_`.

## Functional process 
This table supports the automated email ingestion process (Fetchmail), which allows the ERP to poll external mail servers (POP/IMAP) to convert incoming emails into system records like leads, support tickets, or tasks. It manages the connection parameters, authentication credentials, and synchronization settings for these external mail accounts.

## Description
One row in this table represents a single configured external mail server connection that the system is authorized to poll. It acts as a raw staging entity containing both connection metadata and sensitive authentication tokens (including OAuth2 credentials for Gmail). Its purpose is to provide the configuration state required for the background email fetcher service.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `fetchmail_server_id_seq` |
| port | INTEGER | true | TCP port for the mail server | Typically 993 for IMAP or 995 for POP3 |
| object_id | INTEGER | true | Reference to a related system object | Likely a polymorphic link |
| priority | INTEGER | true | Polling priority | Lower numbers usually indicate higher priority |
| create_uid | INTEGER | true | ID of user who created the record | Foreign key to `res_users` |
| write_uid | INTEGER | true | ID of user who last modified the record | Foreign key to `res_users` |
| name | VARCHAR | false | Descriptive name of the mail server | Display label |
| state | VARCHAR | true | Current status of the connection | e.g., 'draft', 'done' |
| server | VARCHAR | true | Hostname or IP of the mail server | e.g., 'imap.gmail.com' |
| server_type | VARCHAR | false | Protocol type | e.g., 'pop', 'imap' |
| user | VARCHAR | true | Username for authentication | |
| password | VARCHAR | true | Password for authentication | Sensitive: contains plaintext or encrypted password |
| script | VARCHAR | true | Custom script to execute on fetch | |
| configuration | TEXT | true | Additional configuration parameters | Often stored as JSON or serialized data |
| active | BOOLEAN | true | Soft-delete flag | |
| is_ssl | BOOLEAN | true | Use SSL/TLS for connection | |
| attach | BOOLEAN | true | Whether to download attachments | |
| original | BOOLEAN | true | Keep original email on server | |
| date | TIMESTAMP | true | Last synchronization date | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Record modification timestamp | |
| google_gmail_access_token_expiration | INTEGER | true | OAuth2 token expiry epoch | |
| google_gmail_authorization_code | VARCHAR | true | OAuth2 authorization code | Sensitive |
| google_gmail_refresh_token | VARCHAR | true | OAuth2 refresh token | Sensitive |
| google_gmail_access_token | VARCHAR | true | OAuth2 access token | Sensitive |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern)
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains highly sensitive credentials, including `password`, `google_gmail_access_token`, `google_gmail_refresh_token`, and `google_gmail_authorization_code`. These must be masked or excluded in non-production environments.
- **Timestamps:** Timestamps (`date`, `create_date`, `write_date`) are typically stored in UTC by Odoo.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = true` to retrieve only current configurations.
- **Data Integrity:** The `configuration` column is a `TEXT` field that may contain serialized data (e.g., JSON or Pickle), which may require parsing logic depending on the downstream use case.