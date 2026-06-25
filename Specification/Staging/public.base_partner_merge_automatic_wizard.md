# base_partner_merge_automatic_wizard

## Source system
This table originates from Odoo (formerly OpenERP), as evidenced by the naming convention `base_partner_merge_automatic_wizard`, the use of `create_uid`/`write_uid` audit columns, and the `nextval` sequence pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the "Partner Deduplication" business process. It tracks the state and configuration of an automated wizard used to identify and merge duplicate partner (customer/vendor) records within the system based on specific criteria like email, VAT, or name.

## Description