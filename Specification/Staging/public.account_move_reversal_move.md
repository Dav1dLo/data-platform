# account_move_reversal_move

## Source system
The table likely originates from an Odoo ERP system. The naming convention `account_move_reversal_move` is characteristic of Odoo's accounting module, which uses "account moves" to track ledger entries and maintains specific link tables to manage the relationship between original journal entries and their corresponding reversal entries.

## Functional process 
This table supports the accounting reconciliation and audit trail process. It specifically tracks the relationship between an original financial transaction (`move_id`) and the reversing entry (`reversal_id`) created to negate or correct it, ensuring that the ledger maintains a clear history of adjustments.

## Description
One row in this table represents a single link between an accounting journal entry and its associated reversal entry. It serves as a raw landing copy of the relational mapping table from the source ERP, used to reconstruct the audit trail of corrected financial documents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| reversal_id | INTEGER | false | The ID of the reversing journal entry. | References the primary key of the reversal move. |
| move_id | INTEGER | false | The ID of the original journal entry being reversed. | References the primary key of the original move. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`reversal_id`, `move_id`).
- **Foreign keys (inferred):** 
    - `reversal_id` → `account_move.id`: Guessed based on Odoo schema conventions where this column points to the reversing entry.
    - `move_id` → `account_move.id`: Guessed based on Odoo schema conventions where this column points to the original entry.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join-table; it contains no financial amounts or dates, only relational IDs.
- There are no obvious PII columns in this specific table.
- Ensure that joins to the `account_move` table account for potential missing records if the source system performs hard deletes on journal entries.