# mail_message_subtype

## Source system
This table originates from Odoo (formerly OpenERP), an open-source ERP system. The naming convention (`mail_message_subtype`, `res_model`, `create_uid`, `write_uid`) and the use of `JSONB` for translatable fields are characteristic of the Odoo framework's messaging and notification architecture.

## Functional process 
This table supports the Odoo "Discuss" and notification framework, specifically defining the subtypes of messages that can be sent within the system (e.g., "Note", "Comment", "Email"). It dictates which activities or record updates trigger notifications and whether those notifications are internal or visible to external partners, tied to specific models via the `res_model` column.

## Description
One row in this table represents a specific message subtype definition that categorizes communication events within the system. It acts as a configuration entity in the staging layer, providing the metadata required to filter and route notifications for various business objects.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| parent_id | INTEGER | true | Parent subtype reference | Used for hierarchical categorization of subtypes. |
| sequence | INTEGER | true | Display order | Determines the sort order in UI dropdowns. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created this subtype. |
| write_uid | INTEGER | true | Last updater user ID | Foreign key to the user who last modified this subtype. |
| relation_field | VARCHAR | true | Related field name | The field on the model that links to the message. |
| res_model | VARCHAR | true | Resource model | The technical name of the Odoo model (e.g., 'crm.lead'). |
| name | JSONB | false | Display name | Translatable name of the subtype. |
| description | JSONB | true | Description | Translatable long-form description of the subtype. |
| internal | BOOLEAN | true | Internal flag | If true, the message is only visible to internal users. |
| default | BOOLEAN | true | Default flag | Indicates if this subtype is selected by default. |
| hidden | BOOLEAN | true | Hidden flag | If true, the subtype is excluded from standard UI views. |
| track_recipients | BOOLEAN | true | Track recipients | Whether to track recipients for this subtype. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the system upon creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the system upon modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `mail_message_subtype.id`: References the parent subtype in a self-referencing hierarchy.
    - `create_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record creation.
    - `write_uid` → `res_users.id` (guess): Standard Odoo pattern for tracking record updates.
- **Natural keys (inferred):** 
    - None. The table relies on the surrogate `id` for identification.

## Caveats for downstream consumers

- **JSONB fields:** The `name` and `description` columns contain JSONB data, which typically holds language-specific translations (e.g., `{"en_US": "Note", "fr_FR": "Note"}`). Use `->>` operator to extract values.
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo configuration.
- **Soft deletes:** This table does not appear to implement soft deletes; it is a configuration/metadata table where records are typically permanent.
- **Data Sensitivity:** No PII is stored here, though `internal` flags should be respected to ensure data privacy when building reporting layers.