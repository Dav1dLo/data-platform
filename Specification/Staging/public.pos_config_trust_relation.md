# pos_config_trust_relation

## Source system
Unknown — insufficient evidence. The table name suggests a configuration or security mapping, but the column names lack standard prefixes or suffixes that would link them to a specific ERP or CRM system.

## Functional process 
This table supports a configuration or access control process, likely defining trust relationships between entities within the application. The columns suggest a binary relationship mapping where one entity (represented by `is_trusting`) establishes a trust link with another entity (represented by `is_trusted`).

## Description
One row in this table represents a single directional trust relationship between two entities. It is a raw landed copy of a configuration mapping table, serving as the base for downstream security or relationship-based logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| is_trusting | INTEGER | false | The identifier of the entity initiating the trust. | Likely a foreign key to an entity master table. |
| is_trusted | INTEGER | false | The identifier of the entity being trusted. | Likely a foreign key to an entity master table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. The table lacks a surrogate ID and appears to be a composite join table; the combination of `(is_trusting, is_trusted)` is the likely candidate for uniqueness.
- **Foreign keys (inferred):** 
    - `is_trusting` → `unknown_entity_table.id`: Guessed based on the column name implying an entity ID.
    - `is_trusted` → `unknown_entity_table.id`: Guessed based on the column name implying an entity ID.
- **Natural keys (inferred):** 
    - `(is_trusting, is_trusted)`: The unique pair of entities defining the relationship.

## Caveats for downstream consumers

- No PII or sensitive data is immediately apparent, though the IDs may link to sensitive entity records.
- This table appears to be a link table; ensure joins to upstream entity tables handle potential missing records if referential integrity is not enforced at the source.
- There are no audit timestamps (e.g., `created_at` or `updated_at`), so tracking the history of these relationships is not possible from this table alone.