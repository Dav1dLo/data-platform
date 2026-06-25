# stock_package_level

## Source system
This table originates from an Odoo ERP system, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo framework, alongside the `nextval` sequence pattern for the primary key.

## Functional process 
This table supports the inventory management and logistics process, specifically tracking the movement and placement of stock packages within a warehouse. It links specific packages to picking operations and destination locations, facilitating the tracking of goods as they move through the supply chain.

## Description
One row in this table represents a specific instance of a stock package being assigned to a picking operation or a destination location. It serves as a raw landed copy of the Odoo `stock.package.level` model, capturing the state of package-level inventory movements at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `stock_package_level_id_seq`. |
| package_id | INTEGER | false | Foreign key to the stock package | Identifies the specific package being moved. |
| picking_id | INTEGER | true | Foreign key to the picking operation | Links the package level to a specific warehouse picking order. |
| location_dest_id | INTEGER | true | Foreign key to the destination location | The target warehouse location for the package. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organizational entity owning the record. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the entry. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the entry. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `package_id` → `stock_quant_package.id` (Guess: links to the package definition table).
    - `picking_id` → `stock_picking.id` (Guess: links to the parent picking operation).
    - `location_dest_id` → `stock_location.id` (Guess: links to the warehouse location registry).
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company architecture).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains audit fields (`create_uid`, `write_uid`) which may refer to internal system user IDs; these should be joined against a user lookup table if human-readable names are required.
- The table represents a snapshot of the staging layer; it does not explicitly indicate soft-delete status, so assume all records are active unless otherwise filtered by business logic.
- `picking_id` and `location_dest_id` are nullable, suggesting that some package levels may exist independently of a specific active picking operation or destination at certain points in the lifecycle.