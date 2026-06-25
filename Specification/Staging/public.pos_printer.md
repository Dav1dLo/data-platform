# pos_printer

## Source system
This table originates from an Odoo ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of `company_id` are characteristic patterns of Odoo's ORM-based database schema.

## Functional process 
This table supports the Point of Sale (POS) hardware configuration process. It manages the registry of physical or network-connected printers assigned to specific company entities, enabling the POS interface to route receipts and order tickets to the correct hardware via proxy or direct IP.

## Description
One row in this table represents a single printer configuration record linked to a POS system. It serves as a raw landed copy of the printer registry from the source ERP, capturing hardware identifiers, network connectivity details, and audit metadata for each printer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `pos_printer_id_seq` sequence. |
| company_id | INTEGER | false | Foreign key to the company | Links the printer to a specific business entity. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | false | Printer display name | Human-readable label for the printer. |
| printer_type | VARCHAR | true | Category of printer | e.g., 'epson', 'proxy', 'network'. |
| proxy_ip | VARCHAR | true | IP address of the IoT/POS proxy | Used if the printer is connected via a proxy box. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed based on Odoo standards. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed based on Odoo standards. |
| epson_printer_ip | VARCHAR | true | Direct IP address for Epson printers | Specific field for direct network printing. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo deployments.
- **Audit fields:** `create_uid` and `write_uid` are nullable; do not assume every record has an associated user if the record was created via system migration or automated script.
- **Data Integrity:** This is a staging table; verify if `proxy_ip` or `epson_printer_ip` contains valid IPv4/IPv6 formats before using in network-level operations.
- **Soft Deletes:** This table does not appear to contain a boolean `active` flag, which is common in Odoo; assume all rows are currently active unless otherwise specified by business logic.