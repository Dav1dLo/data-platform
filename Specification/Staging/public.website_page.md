# website_page

## Source system
This table originates from an Odoo ERP system, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields for Odoo models. The presence of `website_id` and `theme_template_id` further aligns with the Odoo Website module's data structure.

## Functional process 
This table supports the Content Management System (CMS) functionality within the ERP, specifically managing the configuration and metadata of individual web pages. It tracks page-level settings such as URL routing, visual styling (header/footer visibility and colors), and publication status, facilitating the "Website Builder" business process.

## Description
One row in this table represents a single web page configuration within the CMS, identified by its unique ID and URL. This is a raw landed copy from the source system, serving as the staging entity for website content and layout metadata. It captures the state of a page at the time of extraction, including its publication status and design-specific attributes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `website_page_id_seq`. |
| website_id | INTEGER | true | Foreign key to the website | Links to the parent website container. |
| view_id | INTEGER | false | Reference to the view definition | Links to the underlying QWeb view template. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| theme_template_id | INTEGER | true | Reference to the theme template | Links to the applied design theme. |
| url | VARCHAR | false | URL path of the page | The relative path for the page. |
| header_color | VARCHAR | true | CSS color code for header | Hex or named color for the header background. |
| header_text_color | VARCHAR | true | CSS color code for header text | Hex or named color for header text. |
| is_published | BOOLEAN | true | Publication status | Indicates if the page is live. |
| website_indexed | BOOLEAN | true | SEO indexing flag | Determines if search engines should index the page. |
| is_new_page_template | BOOLEAN | true | Template flag | Indicates if this page is a reusable template. |
| header_overlay | BOOLEAN | true | Header overlay setting | Whether the header overlays the page content. |
| header_visible | BOOLEAN | true | Header visibility toggle | Whether the header is rendered. |
| footer_visible | BOOLEAN | true | Footer visibility toggle | Whether the footer is rendered. |
| date_publish | TIMESTAMP | true | Publication timestamp | The date/time the page was published. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: links to the website configuration table)
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference)
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference)
- **Natural keys (inferred):** 
    - `url` (Assuming unique URL paths per website)

## Caveats for downstream consumers

- **Timestamps:** All `_date` fields are assumed to be in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all rows are active unless filtered by `is_published`.
- **Data Integrity:** `website_id` is nullable, which may imply pages that are not associated with a specific website instance or are global.
- **Sensitive Data:** No PII is present, but `create_uid` and `write_uid` link to internal user records which may contain sensitive employee information.