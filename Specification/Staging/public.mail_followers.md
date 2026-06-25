# mail_followers

## Source system
This table likely originates from an Odoo ERP system. The naming convention (`res_id`, `res_model`, `partner_id`) and the use of a sequence-based primary key are characteristic of Odoo's internal ORM structure, which manages generic follow-up relationships across various business objects.

## Functional process 
This table supports the notification and subscription framework, specifically the "Followers" mechanism. It tracks which business partners (users or contacts) are subscribed to receive updates or communications regarding specific records (e.g., a specific sales order or project task) within the system.

## Description
One row represents a single subscription relationship between a business partner and a specific record in the system. It acts as a junction table that links a `partner_id` to a target record defined by the combination of `res_model` (the entity type) and `res_id` (the specific entity instance). This is a raw staging table representing the direct ingestion of the application's follower registry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses a sequence-based default. |
| res_id | INTEGER | true | Target record ID | The unique identifier of the record being followed. |
| partner_id | INTEGER | false | Subscriber ID | The ID of the partner (user/contact) following the record. |
| res_model | VARCHAR | false | Target model name | The technical name of the entity (e.g., 'sale.order'). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Guess: This column typically references the central partner registry in Odoo).
- **Natural keys (inferred):** 
    - (`res_model`, `res_id`, `partner_id`) — This triplet represents the unique business constraint preventing a partner from following the same record multiple times.

## Caveats for downstream consumers

- **PII/Sensitive Data:** While this table does not contain PII directly, it maps relationships that may reveal sensitive business associations.
- **Data Integrity:** The `res_id` column is nullable, which may occur if a partner is following a model-level feed rather than a specific record instance.
- **Soft Deletes:** This table does not appear to contain `active` or `deleted_at` flags; assume it reflects the current state of the application database.
- **Model Context:** The `res_model` column contains string identifiers; ensure your joins account for the specific model types you are filtering for.