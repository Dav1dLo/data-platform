# res_users_settings_volumes

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention `res_users_settings_volumes` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the user preference and communication settings module, specifically managing custom volume levels for individual partners or guests within a chat or messaging context. It tracks how a specific user has configured the audio volume for different contacts or guest participants.

## Description
One row in this table represents a specific volume configuration setting assigned to a partner or guest by a user. It serves as a raw landed staging table capturing granular audio preferences within the messaging application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence generator. |
| user_setting_id | INTEGER | false | Foreign key to user settings | Links to the parent user configuration. |
| partner_id | INTEGER | true | ID of the partner | The specific contact whose volume is being set. |
| guest_id | INTEGER | true | ID of the guest | The specific guest participant whose volume is being set. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this setting. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this setting. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the application. |
| volume | DOUBLE PRECISION | true | Volume level | Typically a normalized value (e.g., 0.0 to 1.0). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_setting_id` → `res_users_settings.id` (Guess: links to the primary user settings container).
    - `partner_id` → `res_partner.id` (Guess: links to the standard Odoo partner/contact table).
    - `guest_id` → `mail_guest.id` (Guess: links to the messaging guest entity).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user-related identifiers; while not strictly PII, it links user behavior to specific contacts.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a boolean `active` flag; assume rows are hard-deleted if removed from the source.
- **Data Sparsity:** Either `partner_id` or `guest_id` is likely populated per row, but rarely both, depending on whether the target is a registered user or an anonymous guest.