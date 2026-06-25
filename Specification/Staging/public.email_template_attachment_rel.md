# email_template_attachment_rel

## Source system
The table likely originates from a custom application database or a generic CMS/CRM system. The naming convention `_rel` strongly suggests a junction table used to manage many-to-many relationships between email templates and file attachments within an internal application backend.

## Functional process 
This table supports the "Email Notification/Communication" process. It maps specific file attachments to email templates, ensuring that when an email is triggered from a template, the system knows which files (e.g., PDFs, invoices, or marketing collateral) must be attached to the outgoing message.

## Description
One row represents a single association between an email template and an attachment. It acts as a bridge table to resolve a many-to-many relationship, ensuring that multiple attachments can be linked to one template and vice-versa. This is a raw landing copy of the association logic from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| email_template_id | INTEGER | false | Foreign key to the email template definition | Links to the parent template entity. |
| attachment_id | INTEGER | false | Foreign key to the attachment/file metadata | Links to the file storage or metadata entity. |

## Keys

- **Primary key (inferred):** The composite of (`email_template_id`, `attachment_id`).
- **Foreign keys (inferred):** 
    - `email_template_id` → `email_templates.id` (Guess: standard naming convention for parent entities).
    - `attachment_id` → `attachments.id` (Guess: standard naming convention for file entities).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit or timestamp information provided, so the history of when an attachment was linked to a template cannot be determined from this table alone.
- Ensure that joins to parent tables handle potential orphaned records if referential integrity is not strictly enforced in the source system.