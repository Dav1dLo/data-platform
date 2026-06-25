# mail_canned_response

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of the primary key sequence (`public.mail_canned_response_id_seq`) and the standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the "Communication Management" or "Customer Support" process, specifically managing pre-defined email templates or "canned responses" used by agents to standardize replies. It tracks the content of these templates, their usage frequency, and their visibility settings across the organization.

## Description
One row represents a single canned response template available for use in the system. This is a raw landed copy of the Odoo `mail.canned.response` model, serving as the staging layer entity for email automation and communication reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `mail_canned_response_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| source | VARCHAR | false | The shortcut or trigger text | The keyword used to invoke the template. |
| description | VARCHAR | true | Human-readable label | A brief summary of the template's purpose. |
| substitution | TEXT | false | The template body content | Contains the actual message text. |
| is_shared | BOOLEAN | true | Visibility flag | If true, available to all users; otherwise private. |
| last_used | TIMESTAMP | true | Last usage timestamp | Indicates when the template was last applied. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp of initial insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Guessed based on standard Odoo naming conventions for audit fields.
    - `write_uid` → `res_users.id`: Guessed based on standard Odoo naming conventions for audit fields.
- **Natural keys (inferred):** 
    - `source`: In the context of canned responses, the shortcut/trigger text is typically unique within the scope of the user or organization.

## Caveats for downstream consumers

- **Sensitive Data:** The `substitution` column may contain PII or internal communication templates; ensure appropriate access controls.
- **Timestamps:** Timestamps (`create_date`, `write_date`, `last_used`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume all records are currently active unless otherwise specified by Odoo's internal logic.
- **Usage:** The `substitution` column is of type `TEXT` and may contain large amounts of data; be mindful of memory usage when selecting this column in large result sets.