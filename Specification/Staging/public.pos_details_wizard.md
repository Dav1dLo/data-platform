# pos_details_wizard

## Source system
This table originates from an Odoo ERP system. The naming convention `_wizard` is characteristic of Odoo's transient models used to capture user input for temporary reporting or batch processing tasks, and the presence of `create_uid`, `write_uid`, and `*_date` audit columns is standard for Odoo's ORM framework.

## Functional process 
This table supports the "Point of Sale (POS) Reporting" process. It acts as a transient data store for the parameters (specifically the date range) required to generate POS session detail reports or financial summaries within the Odoo POS module.

## Description
One row in this table represents a single execution instance or configuration of a POS details report wizard. It captures the temporal boundaries (`start_date` and `end_date`) defined by a user to filter POS transactions. As a staging table, it represents a raw, landed copy of the wizard's state as it existed in the source application database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `pos_details_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the wizard record | References `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users` table. |
| start_date | TIMESTAMP | false | Beginning of the reporting period | Used to filter POS session data. |
| end_date | TIMESTAMP | false | End of the reporting period | Used to filter POS session data. |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed. |
| write_date | TIMESTAMP | true | Timestamp of last modification | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Transient Nature:** As a "wizard" table, data here is often temporary and may be truncated or cleared by the source system after the report is generated.
- **Timestamps:** All timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Audit Columns:** `create_uid` and `write_uid` may be null if the record was created via system-level processes rather than a specific user session.
- **No Soft Delete:** There is no explicit `active` or `deleted` flag; assume standard CRUD behavior.