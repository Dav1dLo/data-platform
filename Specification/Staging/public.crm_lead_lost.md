# crm_lead_lost

## Source system
This table likely originates from an Odoo ERP or CRM system. The naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, combined with the use of a sequence-based default for the `id` column, is highly characteristic of the Odoo ORM framework.

## Functional process 
This table supports the sales pipeline management process, specifically tracking the reasons and qualitative feedback associated with lost sales opportunities. It captures the "why" behind a lead being marked as lost, which is essential for sales performance analysis and churn mitigation.

## Description
One row in this table represents a single instance of a lost lead event, documenting the reason for the loss and associated user-provided feedback. As a staging table, it serves as a raw, direct ingestion of the source system's loss-tracking records, preserving the original audit trail of who created or modified the record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `crm_lead_lost_id_seq` sequence. |
| lost_reason_id | INTEGER | true | Foreign key to the lost reason lookup table | Categorizes the loss (e.g., "Price", "Competitor"). |
| create_uid | INTEGER | true | User ID who created the record | References the system's internal user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system's internal user table. |
| lost_feedback | TEXT | true | Qualitative notes on the loss | Free-text field for sales representative comments. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lost_reason_id` → `crm_lost_reason.id` (Guess: standard Odoo pattern for linking to a reason dictionary).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `lost_feedback` column may contain PII or sensitive customer information; ensure appropriate masking if exposing to non-authorized users.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by the source system's logic.
- **Audit Fields:** `create_date` and `write_date` should be used for incremental loading patterns (e.g., `WHERE write_date > last_sync_time`).