# utm_tag_rel

## Source system
Unknown — insufficient evidence. The table name suggests a relationship between UTM tracking tags and marketing campaigns, which is common in custom marketing attribution databases or internal tracking systems, but the naming convention does not map to a specific major SaaS platform like Salesforce or HubSpot.

## Functional process 
This table supports the marketing attribution and campaign management process. It acts as a bridge (associative entity) to facilitate a many-to-many relationship between individual tracking tags (e.g., UTM parameters) and specific marketing campaigns.

## Description
One row in this table represents a single association between a specific tag and a specific marketing campaign. It serves as a raw landing copy of a junction table used to normalize the relationship between campaign metadata and tracking identifiers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| tag_id | INTEGER | false | Unique identifier for the UTM tag | Foreign key to a tags dimension table. |
| campaign_id | INTEGER | false | Unique identifier for the marketing campaign | Foreign key to a campaigns dimension table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite primary key on (`tag_id`, `campaign_id`).
- **Foreign keys (inferred):** 
    - `tag_id` → `tags.id`: Guessed based on the column name suffix.
    - `campaign_id` → `campaigns.id`: Guessed based on the column name suffix.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; queries should expect to perform `JOIN` operations against both the `tags` and `campaigns` tables to retrieve human-readable attributes.
- There are no timestamps or audit columns provided, so it is impossible to determine the creation date or lifecycle of these associations.
- The table does not contain soft-delete flags; assume that the presence of a row indicates an active relationship.