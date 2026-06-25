# res_partner_res_partner_category_rel

## Source system
This table originates from an Odoo ERP system. The naming convention `res_partner_res_partner_category_rel` is a standard pattern used by Odoo to define many-to-many relationship tables (often called "relation tables") between the `res_partner` (customer/contact) and `res_partner_category` (tags/labels) entities.

## Functional process 
This table supports the customer relationship management (CRM) process by mapping contacts to specific categories or tags. It allows for the categorization of partners for segmentation, marketing lists, or operational grouping within the business platform.

## Description
One row in this table represents a single association between a partner and a category. It is a raw landed join table used to resolve the many-to-many relationship between partners and their assigned tags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| category_id | INTEGER | false | Foreign key to the category definition | Links to the primary key of the category table. |
| partner_id | INTEGER | false | Foreign key to the partner definition | Links to the primary key of the partner table. |

## Keys

- **Primary key (inferred):** The composite key `(category_id, partner_id)`.
- **Foreign keys (inferred):**
    - `category_id` → `res_partner_category.id`: This column references the category definition table.
    - `partner_id` → `res_partner.id`: This column references the partner/contact master table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only the relationship identifiers.
- There are no timestamps or audit columns present in this table to track when the relationship was created or modified.
- Ensure that joins to this table are handled as inner joins if you only require records with valid associations, or left joins if you are auditing the absence of tags.