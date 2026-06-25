# account_bank_statement_ir_attachment_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_ir_attachment_rel` is a standard pattern used by the Odoo framework to manage many-to-many relationship tables between business objects (in this case, bank statements) and the internal record (`ir`) attachment system.

## Functional process 
This table supports the document management process within the accounting module. It acts as a join table linking specific bank statement records to their associated digital files, such as scanned PDF statements or transaction receipts, stored in the system's attachment repository.

## Description
One row in this table represents a single association between a bank statement record and an attachment record. It serves as a raw landing copy of the join table used to maintain referential integrity between financial statements and their supporting documentation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_bank_statement_id | INTEGER | false | Foreign key to the bank statement | Links to the primary bank statement record. |
| ir_attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the metadata of the stored file. |

## Keys

- **Primary key (inferred):** The composite of (`account_bank_statement_id`, `ir_attachment_id`).
- **Foreign keys (inferred):**
    - `account_bank_statement_id` → `account_bank_statement.id`: This column references the parent bank statement entity.
    - `ir_attachment_id` → `ir_attachment.id`: This column references the central attachment registry.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a link table; it contains no business data other than the relationship itself.
- There are no timestamps or soft-delete flags; if a row is missing, the association has been removed from the source system.
- Ensure that joins to `ir_attachment` are handled carefully, as attachments may be shared across multiple business objects in the Odoo schema.