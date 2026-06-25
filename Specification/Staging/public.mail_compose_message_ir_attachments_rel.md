# mail_compose_message_ir_attachments_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_ir_attachments_rel` is characteristic of Odoo's internal relational mapping tables (Many-to-Many) used to link message composition wizards to their associated file attachments.

## Functional process 
This table supports the document management and communication process within the ERP. It facilitates the attachment of files (e.g., invoices, reports, or supporting documents) to outgoing emails or internal messages generated via the message composition wizard.

## Description
One row in this table represents a single association between a message composition wizard instance and a specific file attachment. It serves as a raw junction table in the staging layer, maintaining the many-to-many relationship required to track which files are linked to which communication event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the message composition wizard | Links to the specific wizard session. |
| attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the actual file metadata. |

## Keys

- **Primary key (inferred):** The combination of `wizard_id` and `attachment_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `wizard_id` → `mail_compose_message.id` (Guess: links to the parent message wizard).
    - `attachment_id` → `ir_attachment.id` (Guess: links to the Odoo attachment registry).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between two entities.
- Expect high cardinality and frequent inserts/deletes during active user sessions.
- There are no timestamps or audit columns; rely on the parent tables for temporal context.
- Ensure joins are performed on both columns to maintain referential integrity when querying.