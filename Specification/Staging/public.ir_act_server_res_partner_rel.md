# ir_act_server_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_act_server_res_partner_rel` follows the standard Odoo pattern for a many-to-many join table linking server actions (`ir_act_server`) to business partners (`res_partner`).

## Functional process 
This table supports the configuration of automated server actions within the Odoo framework. It maps specific server-side actions or automated tasks to the relevant partner records, likely used to trigger workflows or notifications associated with specific entities in the CRM or contact management modules.

## Description
One row in this table represents a single association between a server action and a partner record. It serves as a raw landing copy of the many-to-many relationship table, capturing the link between the `ir_act_server` and `res_partner` entities at the grain of a unique relationship pair.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| ir_act_server_id | INTEGER | false | Foreign key to the server action definition | Links to the `ir_act_server` table. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the `res_partner` table. |

## Keys

- **Primary key (inferred):** The composite key `(ir_act_server_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `ir_act_server_id` → `ir_act_server.id`: This column references the primary key of the server action definition table.
    - `res_partner_id` → `res_partner.id`: This column references the primary key of the partner/contact table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only the relationship identifiers.
- There is no audit or timestamp information available in this table to determine when the relationship was created or modified.
- As a staging table, it reflects the raw state of the Odoo database; ensure that joins to the target tables handle potential orphaned records if referential integrity is not strictly enforced in the source.