# account_invoice_transaction_rel

## Source system
The table likely originates from an ERP or accounting system such as Odoo or a custom financial ledger, given the naming convention `_rel` which is characteristic of join tables in ORM-based database schemas (e.g., SQLAlchemy or Odoo's PostgreSQL implementation).

## Functional process 
This table supports the accounts receivable or billing reconciliation process. It acts as a bridge to maintain a many-to-many relationship between financial invoices and the specific payment transactions or ledger entries that settle them.

## Description
One row in this table represents a single association between an invoice and a transaction. It serves as a raw, junction-table copy in the staging layer, enabling the reconstruction of payment history for specific invoices.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_id | INTEGER | false | Foreign key to the invoice entity | Represents the unique identifier of the billing document. |
| transaction_id | INTEGER | false | Foreign key to the transaction entity | Represents the unique identifier of the payment or ledger movement. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(invoice_id, transaction_id)`.
- **Foreign keys (inferred):** 
    - `invoice_id` → `public.invoice.id` (guess: standard naming convention for invoice references).
    - `transaction_id` → `public.transaction.id` (guess: standard naming convention for transaction references).
- **Natural keys (inferred):** The combination of `(invoice_id, transaction_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes, only relational links.
- Ensure joins are performed on both columns to avoid Cartesian products if the relationship is not strictly 1:1.
- As a staging table, this may contain orphaned records if the source system does not enforce strict referential integrity at the database level.