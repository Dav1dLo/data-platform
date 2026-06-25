# stock_track_confirmation

## Source system
The table likely originates from an Odoo ERP system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default value (`nextval('"public".stock_track_confirmation_id_seq'::regclass)`), is characteristic of Odoo's ORM-generated audit fields.

## Functional process 
This table supports the inventory management or supply chain tracking process, specifically acting as a confirmation log for stock tracking events. It likely records the metadata associated with the creation and modification of stock tracking records, ensuring traceability of who performed an action and when.

## Description
One row in this table represents a single audit record for a stock tracking confirmation event. It serves as a raw landing copy of the system's internal audit trail, capturing the surrogate identifier and the standard Odoo-style user and timestamp metadata for tracking lifecycle changes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence-based default value. |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the system's internal user table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Likely in UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Likely in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for linking audit fields to the user table.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for linking audit fields to the user table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- The table contains audit metadata (`create_uid`, `write_uid`) which may be sensitive if linked to specific employee identities.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table does not appear to contain soft-delete flags (e.g., `active`), suggesting it may only store active records or that deletion is handled via hard-delete.
- The table is a "Staging" layer object; expect raw, uncleaned data that may require joining with master data tables to resolve user IDs or related stock entities.