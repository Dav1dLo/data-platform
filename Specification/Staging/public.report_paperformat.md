# report_paperformat

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific sequence-based primary key pattern common to Odoo's PostgreSQL backend.

## Functional process 
This table supports the document generation and reporting module. It stores configuration profiles for paper sizes and layout settings used when rendering PDF reports, ensuring consistent margins, orientation, and DPI settings across different document types.

## Description
One row in this table represents a single paper format configuration profile used by the reporting engine. It acts as a raw landed copy of the system's paper format definitions, capturing physical dimensions, margin settings, and rendering flags for document output.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `report_paperformat_id_seq`. |
| page_height | INTEGER | true | Page height in millimeters | - |
| page_width | INTEGER | true | Page width in millimeters | - |
| header_spacing | INTEGER | true | Spacing for the document header | - |
| dpi | INTEGER | false | Dots per inch for rendering | - |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users`. |
| name | VARCHAR | false | Descriptive name of the paper format | - |
| format | VARCHAR | true | Standard paper format (e.g., A4, Letter) | - |
| orientation | VARCHAR | true | Page orientation (Portrait/Landscape) | - |
| default | BOOLEAN | true | Flag indicating if this is the system default | - |
| header_line | BOOLEAN | true | Whether to include a header line | - |
| disable_shrinking | BOOLEAN | true | Flag to prevent content shrinking | - |
| css_margins | BOOLEAN | true | Whether to use CSS-based margins | - |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed. |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed. |
| margin_top | DOUBLE PRECISION | true | Top margin size | - |
| margin_bottom | DOUBLE PRECISION | true | Bottom margin size | - |
| margin_left | DOUBLE PRECISION | true | Left margin size | - |
| margin_right | DOUBLE PRECISION | true | Right margin size | - |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for creator).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for modifier).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in UTC as per standard Odoo configuration.
- This table contains configuration data; it does not contain PII or sensitive customer transactional data.
- The `default` column is a reserved keyword in SQL; ensure it is double-quoted (`"default"`) when writing queries.
- No soft-delete flag is present; assume records are hard-deleted if they disappear from the source.