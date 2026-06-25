# ir_mail_server

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the `ir_` (internal resource) prefix, the specific naming convention for audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the presence of Odoo-specific configuration fields for SMTP and Gmail integration.

## Functional process 
This table supports the system's outbound email infrastructure. It stores the configuration details for outgoing mail servers, allowing the application to route notifications, reports, and transactional emails through various SMTP providers or Google Gmail APIs.

## Description
One row in this table represents a single configured outgoing mail server instance. It acts as a raw landing copy of the system's mail server registry, containing connection parameters, authentication credentials, and security settings required for the application to interface with external email services.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| smtp_port | INTEGER | true | SMTP server port | Typically 25, 465, or 587. |
| sequence | INTEGER | true | Display order | Used for UI sorting. |
| create_uid | INTEGER | true | Creator user ID | Reference to user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to user who last updated the record. |
| name | VARCHAR | false | Server name | Descriptive label for the mail server. |
| from_filter | VARCHAR | true | Email address filter | Restricts this server to specific sender addresses. |
| smtp_host | VARCHAR | true | SMTP server hostname | The address of the mail server. |
| smtp_authentication | VARCHAR | false | Auth method | e.g., 'login', 'plain', 'none'. |
| smtp_user | VARCHAR | true | SMTP username | Credential for authentication. |
| smtp_pass | VARCHAR | true | SMTP password | Credential for authentication. |
| smtp_encryption | VARCHAR | false | Encryption protocol | e.g., 'none', 'ssl', 'tls'. |
| smtp_debug | BOOLEAN | true | Debug mode flag | Enables verbose logging if true. |
| active | BOOLEAN | true | Soft-delete flag | If false, the server is disabled. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| max_email_size | DOUBLE PRECISION | true | Max email size limit | In bytes. |
| smtp_ssl_certificate | BYTEA | true | SSL certificate | Binary data for secure connections. |
| smtp_ssl_private_key | BYTEA | true | SSL private key | Binary data for secure connections. |
| google_gmail_access_token_expiration | INTEGER | true | Token expiry | Unix timestamp or duration. |
| google_gmail_authorization_code | VARCHAR | true | OAuth auth code | Used for initial token exchange. |
| google_gmail_refresh_token | VARCHAR | true | OAuth refresh token | Used to obtain new access tokens. |
| google_gmail_access_token | VARCHAR | true | OAuth access token | Current token for Gmail API. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: links to the Odoo users table).
    - `write_uid` → `res_users.id` (Guess: links to the Odoo users table).
- **Natural keys (inferred):** 
    - `name` (In Odoo, the server name is typically unique within the configuration).

## Caveats for downstream consumers

- **Sensitive Data:** This table contains plain-text credentials (`smtp_pass`) and OAuth tokens (`google_gmail_access_token`, `google_gmail_refresh_token`). These must be masked or excluded from non-privileged reporting environments.
- **Soft Deletes:** The `active` column is used for soft deletes. Queries should generally filter by `WHERE active = true` to retrieve only currently valid configurations.
- **Timestamps:** `create_date` and `write_date` are stored in the application's system time, which is typically UTC, but verify against the Odoo instance configuration.
- **Binary Data:** `smtp_ssl_certificate` and `smtp_ssl_private_key` are stored as `BYTEA` and may require specific handling in ETL tools to extract or display.