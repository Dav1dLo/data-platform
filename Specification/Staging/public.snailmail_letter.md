# snailmail_letter

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (e.g., `res_id`, `partner_id`, `create_uid`, `write_uid`) and the presence of specific fields like `model` and `company_id` are characteristic of Odoo's ORM-based database schema.

## Functional process 
This table supports the automated physical mailing process (Snailmail) within the Odoo platform. It tracks the lifecycle of letters generated from business documents (e.g., invoices or purchase orders), managing the association between the source document, the recipient partner, and the physical mailing parameters like color, duplex printing, and cover pages.

## Description
One row in this table represents a single physical letter request initiated within the system. It captures the recipient's address, the document context, and the current processing state of the mailing. As a staging table, it serves as a raw, direct reflection of the Odoo `snailmail.letter` model, used for downstream reporting on mailing volumes and delivery statuses.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| user_id | INTEGER | true | ID of the user who owns the letter | Foreign key to res_users. |
| res_id | INTEGER | false | ID of the source document | Used with 'model' to identify the record. |
| partner_id | INTEGER | false | ID of the recipient partner | Foreign key to res_partner. |
| company_id | INTEGER | false | ID of the owning company | Foreign key to res_company. |
| report_template | INTEGER | true | ID of the report template used | Foreign key to ir_actions_report. |
| attachment_id | INTEGER | true | ID of the generated PDF attachment | Foreign key to ir_attachment. |
| message_id | INTEGER | true | ID of the associated mail message | Foreign key to mail_message. |
| state_id | INTEGER | true | ID of the state/province | Foreign key to res_country_state. |
| country_id | INTEGER | true | ID of the country | Foreign key to res_country. |
| create_uid | INTEGER | true | ID of the user who created the record | Foreign key to res_users. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Foreign key to res_users. |
| model | VARCHAR | false | Technical name of the source model | e.g., 'account.move'. |
| state | VARCHAR | false | Current lifecycle state | e.g., 'pending', 'sent', 'error'. |
| error_code | VARCHAR | true | Error code if mailing failed | Populated if state is 'error'. |
| street | VARCHAR | true | Recipient street address line 1 | |
| street2 | VARCHAR | true | Recipient street address line 2 | |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| info_msg | TEXT | true | Detailed status or error message | |
| color | BOOLEAN | true | Whether the letter is printed in color | |
| cover | BOOLEAN | true | Whether a cover page is included | |
| duplex | BOOLEAN | true | Whether the letter is double-sided | |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `user_id` → `res_users.id` (Standard Odoo user association)
    - `partner_id` → `res_partner.id` (Standard Odoo partner association)
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture)
    - `country_id` → `res_country.id` (Standard Odoo localization)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains physical mailing addresses (`street`, `city`, `zip`) which should be treated as PII.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are stored in UTC, consistent with Odoo's internal database standards.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are hard-deleted if removed from the source.
- **Polymorphism:** The `res_id` and `model` columns form a polymorphic relationship; queries joining to the source document must filter by both columns.