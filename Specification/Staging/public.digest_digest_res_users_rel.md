# digest_digest_res_users_rel

## Source system
This table likely originates from an Odoo ERP or a similar Python-based framework using an ORM that generates junction tables for many-to-many relationships. The naming convention `_rel` combined with the prefix `digest_digest` and `res_users` strongly suggests a relational mapping between a digest configuration and the users subscribed to receive it.

## Functional process 
This table supports the user notification and reporting subscription process. It manages the many-to-many relationship between digest email configurations and the specific system users who are designated to receive those digests.

## Description
One row in this table represents a single association between a specific digest configuration and a user. It serves as a raw landing copy of the junction table used to resolve many-to-many relationships in the source system, ensuring that multiple users can be linked to multiple digest reports.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| digest_digest_id | INTEGER | false | Foreign key to the digest configuration | Links to the parent digest definition. |
| res_users_id | INTEGER | false | Foreign key to the system user | Links to the user receiving the digest. |

## Keys

- **Primary key (inferred):** The combination of `(digest_digest_id, res_users_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `digest_digest_id` → `digest_digest.id` (guess: standard Odoo-style naming convention).
    - `res_users_id` → `res_users.id` (guess: standard Odoo-style naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no attributes other than the two foreign keys.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure joins are performed on both columns to maintain the integrity of the many-to-many relationship.