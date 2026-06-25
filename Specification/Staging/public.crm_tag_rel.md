# crm_tag_rel

## Source system
The table likely originates from a CRM system (e.g., Salesforce, HubSpot, or a custom-built lead management application). The naming convention `crm_tag_rel` strongly suggests a relational mapping table used to associate tags with lead records within a customer relationship management module.

## Functional process 
This table supports the lead management and segmentation process. It enables a many-to-many relationship between leads and descriptive tags, allowing users to categorize leads based on interests, status, or marketing campaign participation.

## Description
One row in this table represents a single association between a lead and a specific tag. It serves as a raw landing copy of a join table, facilitating the normalization of lead-tag relationships within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| lead_id | INTEGER | false | Foreign key referencing the lead record. | Likely links to a `leads` or `crm_leads` table. |
| tag_id | INTEGER | false | Foreign key referencing the tag definition. | Likely links to a `tags` or `crm_tags` table. |

## Keys

- **Primary key (inferred):** The composite of `(lead_id, tag_id)`.
- **Foreign keys (inferred):** 
    - `lead_id` → `leads.id`: This column identifies the specific lead being tagged.
    - `tag_id` → `tags.id`: This column identifies the specific tag being applied to the lead.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes other than the relationship itself.
- There are no timestamps or audit columns provided; it is impossible to determine when these associations were created or modified.
- Ensure that joins to parent tables (`leads` or `tags`) handle potential orphans if referential integrity is not strictly enforced at the source.