# payment_capture_wizard_payment_transaction_rel

## Source system
The table likely originates from a custom internal application or a workflow orchestration system, given the naming convention "payment_capture_wizard". This suggests a multi-step UI or backend process that manages payment capture, where this table acts as an association entity between the wizard session and the resulting transaction.

## Functional process 
This table supports the payment processing pipeline by maintaining the relationship between a specific payment capture session (the "wizard") and the underlying financial transaction record. It is used to track which transactions were generated or associated with a specific user-driven payment flow.

## Description
One row represents a single association between a payment capture wizard instance and a payment transaction. As a staging table, it serves as a raw, normalized link record used to reconstruct the lineage between user-initiated payment flows and backend transaction logs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_capture_wizard_id | INTEGER | false | Foreign key to the payment capture wizard session. | None |
| payment_transaction_id | INTEGER | false | Foreign key to the payment transaction record. | None |

## Keys

- **Primary key (inferred):** The combination of `payment_capture_wizard_id` and `payment_transaction_id` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `payment_capture_wizard_id` → `payment_capture_wizard.id` (Guess: links to the wizard session table).
    - `payment_transaction_id` → `payment_transaction.id` (Guess: links to the core transaction table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join/link table; it contains no descriptive attributes or timestamps.
- There is no explicit soft-delete flag; assume standard relational integrity where records are removed if the association is severed.
- Ensure joins are performed on both columns to avoid Cartesian products if a wizard session is ever associated with multiple transactions.