# confirm_stock_sms

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default for the `id` column are characteristic patterns of the Odoo framework's ORM layer.

## Functional process 
This table supports an automated notification or confirmation process related to stock management, specifically triggering SMS alerts. It likely tracks the audit trail of records created or modified by users within the inventory or warehouse management modules to confirm stock-related actions.

## Description
Each row represents a single SMS confirmation event or request generated within the stock management workflow. As a staging table, it serves as a raw, landed copy of the source system's transactional data, capturing the audit metadata for these specific stock-related communications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `public.confirm_stock_sms_id_seq` sequence. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user registry. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user registry. |
| create_date | TIMESTAMP | true | Creation timestamp | Likely in UTC; records when the SMS event was initiated. |
| write_date | TIMESTAMP | true | Last modification timestamp | Likely in UTC; records the last update to the record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** While this table does not contain the SMS body or recipient phone numbers, the `create_uid` and `write_uid` columns link to internal user identities.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are active unless otherwise specified by the source system's business logic.
- **Data Completeness:** As a staging table, ensure that downstream joins account for potential nulls in `create_uid` and `write_uid` if the records were system-generated rather than user-initiated.