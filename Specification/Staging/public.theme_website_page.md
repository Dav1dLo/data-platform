# theme_website_page

## Source system
This table originates from an Odoo ERP environment, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the sequence-based default value for the primary key.

## Functional process 
This table supports the website content management process within the ERP, specifically tracking the configuration and publication status of individual web pages. It manages metadata for page rendering, such as header visibility, indexing status, and template definitions.

## Description
One row in this table represents a single website page configuration, including its URL, visual properties, and publication state. As a staging table, it provides a raw, direct representation of the underlying database records used to drive the website's front-end display logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `theme_website_page_id_seq` sequence. |
| view_id | INTEGER | false | Foreign key to the view definition | Likely links to an internal Odoo view or template record. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system user table. |
| url | VARCHAR | true | The relative URL path of the page | The web address identifier for the page. |
| header_color | VARCHAR | true | CSS color code for the header | Defines the visual styling of the page header. |
| website_indexed | BOOLEAN | true | SEO indexing flag | Indicates if the page should be crawled by search engines. |
| is_published | BOOLEAN | true | Publication status | Determines if the page is live on the website. |
| is_new_page_template | BOOLEAN | true | Template flag | Indicates if this record serves as a template for new pages. |
| header_overlay | BOOLEAN | true | Header overlay toggle | Controls if the header is rendered as an overlay. |
| header_visible | BOOLEAN | true | Header visibility toggle | Controls if the header is displayed. |
| footer_visible | BOOLEAN | true | Footer visibility toggle | Controls if the footer is displayed. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server local time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Guess: Standard Odoo pattern for linking pages to view definitions).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit field pattern).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit field pattern).
- **Natural keys (inferred):** 
    - `url` (Assuming unique URLs per website instance).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may link to internal employee or user records.
- **Timestamps:** Timestamps are typically stored in the server's local time; verify the server timezone configuration before performing time-series analysis.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted from the source.
- **Data Quality:** Boolean fields (`is_published`, `website_indexed`) may contain nulls if the source system defaults were not explicitly set during record creation.