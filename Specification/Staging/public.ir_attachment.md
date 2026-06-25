# ir_attachment

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention `ir_attachment` (Internal Resource attachment) and the presence of columns like `res_model`, `res_id`, `create_uid`, and `write_uid` are characteristic of Odoo's core framework for managing file attachments linked to business records.

## Functional process 
This table supports the document management and file storage process across the ERP. It acts as a central repository for binary files, URLs, and metadata associated with various business entities (e.g., invoices, product images, or email attachments), linking them to specific records via the `res_model` and `res_id` fields.

## Description
One row in this table represents a single file or external URL attachment linked to a specific record within the Odoo system. It serves as a raw landing copy of the attachment metadata and, in some cases, the binary data itself. The grain is one row per attachment instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `ir_attachment_id_seq`. |
| res_id | INTEGER | true | ID of the related record | Links to the record ID in the table specified by `res_model`. |
| company_id | INTEGER | true | Owning company ID | Multi-company context identifier. |
| file_size | INTEGER | true | Size of the file in bytes | - |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| name | VARCHAR | false | Display name of the attachment | - |
| res_model | VARCHAR | true | Technical name of the related model | e.g., 'account.move', 'product.product'. |
| res_field | VARCHAR | true | Specific field name on the model | Used if the attachment is stored in a specific binary field. |
| type | VARCHAR | false | Attachment type | 'binary' (file) or 'url' (link). |
| url | VARCHAR(1024) | true | External URL | Populated if `type` is 'url'. |
| access_token | VARCHAR | true | Security token for public access | Used for sharing attachments externally. |
| store_fname | VARCHAR | true | Filename on the storage backend | Path or name in the filestore. |
| checksum | VARCHAR(40) | true | SHA1 or similar file hash | Used for integrity checks. |
| mimetype | VARCHAR | true | MIME type of the file | e.g., 'application/pdf', 'image/png'. |
| description | TEXT | true | User-provided description | - |
| index_content | TEXT | true | Extracted text for search | Used for full-text search indexing. |
| public | BOOLEAN | true | Public access flag | If true, accessible without authentication. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| db_datas | BYTEA | true | Binary file content | Only if stored in the database (not filestore). |
| original_id | INTEGER | true | Reference to original attachment | Used for versioning or copies. |
| website_id | INTEGER | true | Associated website ID | Context for e-commerce/web modules. |
| theme_template_id | INTEGER | true | Associated theme template ID | Used for website design assets. |
| key | VARCHAR | true | Unique key identifier | Often used for specific system-level assets. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field)
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company field)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Binary Data:** The `db_datas` column contains raw binary data (`BYTEA`). Querying this column directly can cause significant performance degradation and memory issues; exclude it unless strictly necessary.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage standards.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically hard-deleted in Odoo.
- **Storage Location:** Files may be stored in the database (`db_datas`) or on the filesystem (`store_fname`). Check the `type` column to determine how to access the content.