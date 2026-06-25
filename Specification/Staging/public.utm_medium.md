# utm_medium

## Source system
This table likely originates from an Odoo ERP or a similar modular business application. The presence of `create_uid`, `write_uid`, and the specific sequence-based default for the `id` column are characteristic patterns of the Odoo ORM (Object-Relational Mapping) framework.

## Functional process 
This table supports marketing attribution and campaign tracking processes. It serves as a lookup or reference table for "mediums" (e.g., "email", "cpc", "social") used in UTM parameters to categorize the source of incoming web traffic or lead generation activities.

## Description
One row in this table represents a single marketing medium category used to track the channel through which a user arrived at the platform. This is a raw landed staging table, providing a direct copy of the source system's configuration data for marketing attribution.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `public.utm_medium_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| name | VARCHAR | false | The name of the medium | e.g., 'email', 'cpc', 'organic'. |
| active | BOOLEAN | true | Soft-delete flag | If false, the medium is no longer in use. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `name` (The unique label for the marketing medium).

## Caveats for downstream consumers

- **Sensitive Data:** No PII or sensitive financial data present.
- **Timestamps:** Assumed to be in UTC; verify against system configuration if precision is required for audit logs.
- **Soft Deletes:** The `active` column indicates a soft-delete pattern; ensure queries filter by `active = true` to retrieve only current, valid mediums.
- **Data Integrity:** As a staging table, this may contain duplicates or inconsistent naming conventions if the source system allows manual entry of medium names.