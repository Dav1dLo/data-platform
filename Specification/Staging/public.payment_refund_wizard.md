# payment_refund_wizard

## Source system
The table likely originates from an Odoo ERP system, as evidenced by the naming convention of `create_uid`, `write_uid`, `create_date`, and `write_date` columns, which are standard audit fields in Odoo, and the use of a sequence-based default for the `id` column.

## Functional process 
This table supports the customer service or finance business process for handling payment refunds. It acts as a temporary staging or "wizard" state table used to capture parameters—specifically the `amount_to_refund`—before a refund transaction is finalized against a specific `payment_id`.

## Description
One row in this table represents a single refund request session or "wizard" instance initiated by a user. It serves as a raw landing copy of the transient data used during the refund workflow, capturing the intended refund amount and the audit trail of the user who created or modified the request.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `payment_refund_wizard_id_seq`. |
| payment_id | INTEGER | true | Foreign key to the payment being refunded | Links to the source payment record. |
| create_uid | INTEGER | true | ID of the user who created the record | References the system's user table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the system's user table. |
| amount_to_refund | NUMERIC | true | The monetary value requested for refund | Precision depends on the source currency settings. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely in UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_id` → `payment.id` (Guess: links to the primary payment record).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) and financial amounts; ensure appropriate access controls are applied.
- **Timestamps:** Assumed to be in UTC; verify against system configuration if precision is required for audit logs.
- **Data Lifecycle:** As a "wizard" table, rows may be transient or intended for deletion after the refund process completes; check for high volumes of stale records.
- **Nullability:** Most fields are nullable, suggesting that records may be partially populated during the initial stages of the wizard workflow.