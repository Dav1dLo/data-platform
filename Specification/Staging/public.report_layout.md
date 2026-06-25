# report_layout

## Source system
This table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of `nextval` sequences for the primary key, is characteristic of Odoo's internal ORM structure for managing report configurations.

## Functional process 
This table supports the document generation and reporting module. It stores layout configurations for specific report views, defining the sequence and associated assets (images or PDF templates) used when rendering business documents like invoices or purchase orders.

## Description
One row in this table represents a specific layout configuration associated with a report view. It serves as a raw landed copy of the report layout metadata, capturing the display order and references to external file assets used in the reporting engine.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.report_layout_id_seq`. |
| view_id | INTEGER | false | Foreign key to the report view definition | Links to the parent report view. |
| sequence | INTEGER | true | Display order index | Used to sort layouts within a view. |
| create_uid | INTEGER | true | ID of the user who created the record | Reference to a user table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Reference to a user table. |
| image | VARCHAR | true | Path or binary reference to an image asset | Likely a file path or URL. |
| pdf | VARCHAR | true | Path or binary reference to a PDF template | Likely a file path or URL. |
| name | VARCHAR | true | Descriptive name of the layout | Human-readable label. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Guess: standard Odoo naming convention for view references).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- The `image` and `pdf` columns likely contain file paths or relative URIs rather than binary blobs; verify if these point to a local file system or an object store.
- This is a staging table; expect raw data that may contain duplicates or incomplete records if the upstream Odoo instance has undergone partial migrations or manual database edits.