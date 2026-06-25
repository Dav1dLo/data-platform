# mail_link_preview

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of PostgreSQL sequence-based default values for the primary key.

## Functional process 
This table supports the communication and collaboration module, specifically the link preview functionality within email or messaging threads. It stores metadata extracted from URLs shared in messages to provide rich previews (Open Graph tags) to end users.

## Description
One row represents a single cached link preview associated with a specific message. It acts as a raw landing copy of the metadata extracted from a URL, including Open Graph properties like titles, descriptions, and image paths, used to render link previews in the application UI.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_link_preview_id_seq`. |
| message_id | INTEGER | true | Foreign key to the parent message | Links the preview to a specific communication record. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res_users`. |
| source_url | VARCHAR | false | The original URL being previewed | The primary identifier for the content source. |
| og_type | VARCHAR | true | Open Graph object type | e.g., 'website', 'article'. |
| og_title | VARCHAR | true | Open Graph title | The title metadata extracted from the URL. |
| og_site_name | VARCHAR | true | Open Graph site name | The name of the hosting website. |
| og_image | VARCHAR | true | URL of the preview image | Path to the image asset. |
| og_mimetype | VARCHAR | true | MIME type of the Open Graph content | Describes the content format. |
| image_mimetype | VARCHAR | true | MIME type of the preview image | e.g., 'image/jpeg', 'image/png'. |
| og_description | TEXT | true | Open Graph description | The summary text extracted from the URL. |
| is_hidden | BOOLEAN | true | Visibility flag | Indicates if the preview should be suppressed. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id` (Guess: standard Odoo naming pattern for message associations).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable. While `source_url` is unique in context, it may be shared across different messages.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Data Sensitivity:** `source_url` may contain sensitive query parameters or private tokens; handle with care.
- **Soft Deletes:** There is no explicit `active` or `deleted_at` column; however, `is_hidden` may function as a UI-level filter for content.
- **Nullability:** Many fields (especially Open Graph metadata) are nullable, as extraction may fail or the target URL may lack OG tags.