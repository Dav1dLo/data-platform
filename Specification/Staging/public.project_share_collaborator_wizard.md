# project_share_collaborator_wizard

## Source system
This table likely originates from an Odoo ERP or a similar modular business application, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequence-based primary keys (`nextval` on `id`).

## Functional process 
This table supports a collaborative project-sharing workflow, specifically managing the "wizard" or transient state of inviting external partners to access project resources. It tracks the configuration of these invitations, such as the intended access level and whether an invitation email should be triggered.

## Description
One row in this table represents a single configuration instance of a project-sharing invitation wizard session. It serves as a raw landing copy of the transient state used to facilitate the assignment of collaborators to projects before the data is persisted to permanent access control tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `project_share_collaborator_wizard_id_seq`. |
| parent_wizard_id | INTEGER | true | Reference to a parent wizard session | Likely used for multi-step wizard flows. |
| partner_id | INTEGER | false | Foreign key to the partner/user being invited | Represents the target entity receiving access. |
| create_uid | INTEGER | true | ID of the user who created this record | References the system's internal user table. |
| write_uid | INTEGER | true | ID of the user who last updated this record | References the system's internal user table. |
| access_mode | VARCHAR | false | Permission level granted to the collaborator | e.g., 'read', 'write', 'admin'. |
| send_invitation | BOOLEAN | true | Flag to trigger an invitation notification | If true, an email or alert is sent to the partner. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id → res_partner.id` (Guess: standard Odoo pattern for partner references).
    - `create_uid → res_users.id` (Guess: standard Odoo pattern for user audit trails).
    - `write_uid → res_users.id` (Guess: standard Odoo pattern for user audit trails).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and user audit IDs; ensure appropriate access controls are in place.
- **Timezone:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo/PostgreSQL deployments.
- **Data Lifecycle:** As a "wizard" table, rows may be transient and subject to frequent deletion or truncation after the invitation process is completed.
- **Nullability:** `parent_wizard_id` is frequently null if the wizard is not part of a nested process.