# account_payment_account_bank_statement_line_rel

## Source system
This table likely originates from an Odoo ERP system. The naming convention `_rel` is a standard pattern used by Odoo to represent many-to-many relationship tables (link tables) between two core business entities.

## Functional process 
This table supports the bank reconciliation and payment matching process. It maps individual bank statement lines to specific payment records, ensuring that incoming or outgoing bank transactions are correctly reconciled against the corresponding payment entries in the ledger.

## Description
One row in this table represents a single association between a bank statement line and a payment record. It acts as a join table to facilitate a many-to-many relationship, serving as a raw landed copy of the link between financial transactions in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_bank_statement_line_id | INTEGER | false | Foreign key to the bank statement line | Links to the specific line item on a bank statement. |
| account_payment_id | INTEGER | false | Foreign key to the payment record | Links to the specific payment transaction. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of both columns.
- **Foreign keys (inferred):** 
    - `account_bank_statement_line_id` → `account_bank_statement_line.id`: This column references the primary identifier of a bank statement line.
    - `account_payment_id` → `account_payment.id`: This column references the primary identifier of a payment record.
- **Natural keys (inferred):** The combination of `(account_bank_statement_line_id, account_payment_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with both the bank statement lines and payment tables to retrieve meaningful business attributes.
- There are no timestamps or audit columns present; it is impossible to determine the sequence of creation or updates from this table alone.
- As a staging table, it contains raw identifiers; ensure referential integrity is validated against the parent tables before performing heavy analytical joins.