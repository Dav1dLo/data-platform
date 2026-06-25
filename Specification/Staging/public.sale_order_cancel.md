# sale_order_cancel

## Source system
This table likely originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the presence of a `template_id` and `order_id` structure are characteristic of Odoo's ORM-based database schema, which tracks record creation and modification metadata alongside business objects.

## Functional process 
This table supports the sales order cancellation workflow, specifically managing the communication or notification process when an order is cancelled. It appears to store the templates, content, and audit trails for messages sent to customers or internal stakeholders regarding the cancellation of a specific sales order.

## Description
One row in this table represents a single cancellation notification or record associated with a sales order. It serves as a raw landing copy of the cancellation event data, capturing the message content, language, and the users responsible for the record's lifecycle.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `sale_order_cancel_id_seq` |
| template_id | INTEGER | true | Foreign key to email/message template | Used to format the cancellation notice |
| author_id | INTEGER | true | ID of the user who authored the cancellation | Likely links to a user or partner table |
| order_id | INTEGER | false | Foreign key to the cancelled sales order | The business object being cancelled |
| create_uid | INTEGER | true | ID of the user who created this record | Audit field |
| write_uid | INTEGER | true | ID of the user who last updated this record | Audit field |
| lang | VARCHAR | true | Language code for the message | e.g., 'en_US', 'fr_FR' |
| subject | VARCHAR | true | Subject line of the cancellation message | |
| body | TEXT | true | HTML or plain text content of the message | |
| create_date | TIMESTAMP | true | Timestamp of record creation | |
| write_date | TIMESTAMP | true | Timestamp of last record update | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `sale_order.id` (Inferred from the business context of sales order cancellation).
    - `author_id` → `res_users.id` (Standard Odoo pattern for user-linked fields).
    - `template_id` → `mail_template.id` (Standard Odoo pattern for email templates).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain customer-specific information or internal notes; ensure appropriate masking if exposed to non-authorized users.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo-based systems, but verify against the application configuration.
- **Data Integrity:** As this is a staging table, it may contain multiple versions of the same cancellation event if the record was updated; use `write_date` to identify the most recent state.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted` flag; assume all records are current unless otherwise specified by the source system logic.