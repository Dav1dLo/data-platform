# res_users_deletion

## Source system
This table originates from an Odoo ERP system. The naming convention `res_users_deletion` and the presence of audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date` are characteristic of Odoo's internal resource management tables.

## Functional process 
This table supports the user account lifecycle management process, specifically tracking requests or processes for user account deletion. It likely acts as a staging log for pending or completed deletions of user records within the ERP.

## Description
One row in this table represents a single user deletion request or event. It serves as a raw landing record in the staging layer, capturing the state of a deletion process initiated for a specific user.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `res_users_deletion_id_seq`. |
| user_id | INTEGER | true | Reference to the user being deleted | Likely links to `res_users.id`. |
| user_id_int | INTEGER | true | Internal identifier for the user | Redundant or legacy identifier for the user. |
| create_uid | INTEGER | true | ID of the user who created this record | Links to `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated this record | Links to `res_users.id`. |
| state | VARCHAR | false | Current status of the deletion request | e.g., 'draft', 'pending', 'done'. |
| create_date | TIMESTAMP | true | Timestamp of record creation | UTC assumed. |
| write_date | TIMESTAMP | true | Timestamp of last record update | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id`: Represents the target user record being processed for deletion.
    - `create_uid` → `res_users.id`: Represents the system user who initiated the deletion request.
    - `write_uid` → `res_users.id`: Represents the system user who last modified the request status.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `user_id` and `user_id_int` columns are both present; verify which one is the reliable foreign key for your join logic.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit trails (`create_uid`, `write_uid`) which may refer to users who have themselves been deleted or deactivated.
- The `state` column is a free-text `VARCHAR`; expect non-standardized values if the source system allows manual entry.