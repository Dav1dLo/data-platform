# portal_share

## Source system
This table originates from an Odoo ERP system. The naming convention of columns such as `res_id`, `res_model`, `create_uid`, and `write_uid`, combined with the use of standard Odoo sequence generators (`nextval('"public".portal_share_id_seq'::regclass)`), is characteristic of the Odoo ORM framework.

## Functional process 
This table supports the document or record sharing functionality within the platform. It tracks instances where specific records (identified by `res_model` and `res_id`) are shared via the portal, likely storing metadata or notes associated with these sharing events to facilitate external access or collaboration.

## Description
One row in this table represents a single sharing event or configuration for a specific record within the system. It acts as a raw landing copy of the sharing registry, capturing which user initiated the share, the target record, and any associated notes. The grain is one row per portal share instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| res_id | INTEGER | false | Resource ID | The ID of the record being shared in the source model. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the share record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the share record. |
| res_model | VARCHAR | false | Resource model name | The technical name of the Odoo model (e.g., 'sale.order'). |
| note | TEXT | true | Sharing note | Optional descriptive text regarding the share. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of when the share record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to the share record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo naming convention for user references).
    - `write_uid` → `res_users.id` (Inferred from Odoo naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable. The combination of `res_model` and `res_id` likely identifies the target, but multiple share records may exist for the same resource.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access is restricted if user PII is exposed in the linked `res_users` table.
- **Timestamps:** Timestamps are typically stored in UTC by the Odoo framework, but verify against the application server configuration.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume all records are current unless otherwise specified by business logic.
- **Model Polymorphism:** The `res_model` column indicates that `res_id` refers to different tables depending on the value of `res_model`. Joins will require dynamic SQL or `CASE` statements.