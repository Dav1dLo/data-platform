# refunded_invoices

## Source system
The table likely originates from an ERP or accounting system such as Odoo, given the specific terminology "account_move," which is the standard nomenclature for journal entries and invoice records in that ecosystem.

## Functional process 
This table supports the accounts receivable and financial reconciliation process by mapping credit notes or refund documents to their original invoice counterparts. It facilitates the tracking of financial adjustments and the reversal of revenue recognition.

## Description
One row in this table represents a single link between a refund document and the original invoice it offsets. It serves as a raw landing record in the staging layer, capturing the relationship between two distinct financial movements within the ledger.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| refund_account_move | INTEGER | false | The unique identifier of the refund or credit note document. | References the primary key of the account move table. |
| original_account_move | INTEGER | false | The unique identifier of the original invoice being refunded. | References the primary key of the account move table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of both columns or a surrogate ID not present in this staging extract.
- **Foreign keys (inferred):** 
    - `refund_account_move` → `account_move.id`: This column identifies the specific financial document acting as the refund.
    - `original_account_move` → `account_move.id`: This column identifies the specific financial document being offset.
- **Natural keys (inferred):** The combination of `(refund_account_move, original_account_move)` is the business key representing the link between these two ledger entries.

## Caveats for downstream consumers

- This table contains no timestamps; it is strictly a mapping table and does not indicate when the refund occurred.
- There is no explicit soft-delete flag; assume that the presence of a row indicates an active relationship in the source system.
- Ensure that joins to the `account_move` table are handled carefully, as `original_account_move` may appear multiple times if an invoice is partially refunded across multiple credit notes.