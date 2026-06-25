# mail_mail_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `_rel` combined with the specific column names `mail_mail_id` and `res_partner_id` is characteristic of Odoo's automated many-to-many relationship tables used to link email records to partner entities.

## Functional process 
This table supports the communication tracking process, specifically managing the many-to-many relationship between outgoing email records and the business partners (customers, vendors, or internal users) associated with them. It facilitates the tracking of email recipients or participants in the CRM or messaging modules.

## Description
One row in this table represents a single association between an email record and a partner entity. It serves as a raw landing junction table in the staging layer, enabling the reconstruction of email distribution lists or participant history.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_mail_id | INTEGER | false | Foreign key to the email record | References the primary email entity. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | References the recipient or associated partner. |

## Keys

- **Primary key (inferred):** The composite of `(mail_mail_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `mail_mail_id` → `mail_mail.id`: Links to the specific email message record.
    - `res_partner_id` → `res_partner.id`: Links to the specific partner record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect high cardinality and frequent joins to the parent `mail_mail` and `res_partner` tables.
- No timestamps or audit columns are present; this table reflects the current state of associations as captured during the last ingestion.
- There are no sensitive PII columns directly in this table, but joining with `res_partner` will expose contact information.