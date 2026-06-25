# payment_capture_wizard

## Source system
This table likely originates from an Odoo ERP instance, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of a sequence-based default value for the primary key, which is characteristic of the Odoo ORM.

## Functional process 
This table supports the payment processing workflow, specifically the "capture" phase of a transaction. It tracks the state of a wizard or temporary process used to finalize payments, allowing users to specify the amount to capture and whether to void any remaining authorized funds.

## Description
One row represents a single instance of a payment capture operation initiated within the system. It serves as a staging record for the parameters of a capture request before it is processed against a payment gateway.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `payment_capture_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system user table. |
| amount_to_capture | NUMERIC | true | The specific currency amount to be captured | Likely represents the transaction value. |
| void_remaining_amount | BOOLEAN | true | Flag to void uncaptured funds | If true, releases the remaining authorization. |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed. |
| write_date | TIMESTAMP | true | Timestamp of last record update | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess based on Odoo naming convention).
    - `write_uid` → `res_users.id` (guess based on Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs; ensure access is restricted if mapping to PII-heavy user tables.
- **Timestamps:** Assumed to be in UTC; verify against system configuration if precision is required for audit logs.
- **Data Lifecycle:** This is a staging table; records may be transient or purged after the capture process is completed.
- **Nullability:** Most fields are nullable, suggesting that not all capture operations require the same level of detail or that records may be partially populated during the wizard flow.