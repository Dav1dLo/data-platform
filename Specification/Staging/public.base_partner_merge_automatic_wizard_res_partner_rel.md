# base_partner_merge_automatic_wizard_res_partner_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `base_partner_merge_automatic_wizard_res_partner_rel` is characteristic of Odoo's automated many-to-many relation tables, specifically those generated for wizard-based data cleaning operations.

## Functional process 
This table supports the "Customer/Partner Data Deduplication" process. It acts as a join table for the automated wizard that identifies and merges duplicate partner records within the CRM or contact management module.

## Description
One row in this table represents a single association between a specific deduplication wizard instance and a partner record identified for processing. It serves as a raw landing copy of the relationship state during the execution of a merge operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| base_partner_merge_automatic_wizard_id | INTEGER | false | Foreign key to the parent wizard instance | Links to the specific execution of the merge tool. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | The ID of the partner being processed by the wizard. |

## Keys

- **Primary key (inferred):** The composite of (`base_partner_merge_automatic_wizard_id`, `res_partner_id`).
- **Foreign keys (inferred):** 
    - `base_partner_merge_automatic_wizard_id` → `base_partner_merge_automatic_wizard.id`: Links to the wizard configuration/execution record.
    - `res_partner_id` → `res_partner.id`: Links to the core partner/customer entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a technical join table; it does not contain business attributes, only relationship mappings.
- The table is likely transient or highly volatile, as it is tied to the lifecycle of a specific wizard execution.
- No audit timestamps are present; it is impossible to determine the age of these relationships without joining to the parent wizard table.