# product_packaging

## Source system
This table originates from an Odoo ERP system. The naming conventions for audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of sequences for primary keys are characteristic of the Odoo ORM framework.

## Functional process 
This table supports the inventory and logistics management process, specifically defining how products are packaged for procurement and sales. It links products to specific packaging configurations, including barcodes and quantities, which are used to manage stock units and supply chain operations.

## Description
One row in this table represents a specific packaging configuration for a product, defining attributes such as the quantity contained and the associated barcode. As a staging table, it serves as a raw, landed copy of the Odoo `product.packaging` model, intended for use in downstream transformation pipelines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `product_packaging_id_seq` |
| sequence | INTEGER | true | Display order index | Used for UI sorting |
| product_id | INTEGER | false | Foreign key to product | Links to the parent product |
| company_id | INTEGER | true | Multi-company scope | Null if shared across companies |
| create_uid | INTEGER | true | Creator user ID | Reference to res.users |
| write_uid | INTEGER | true | Last modifier user ID | Reference to res.users |
| name | VARCHAR | false | Packaging name/label | Descriptive identifier |
| barcode | VARCHAR | true | GS1 or internal barcode | Used for scanning |
| qty | NUMERIC | true | Quantity per package | Unit of measure defined by product |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed |
| package_type_id | INTEGER | true | Packaging type reference | Links to product.packaging.type |
| purchase | BOOLEAN | true | Available for purchase | Flag for procurement use |
| sales | BOOLEAN | true | Available for sales | Flag for sales order use |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_template.id` (Guess: standard Odoo product link)
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link)
    - `package_type_id` → `product_packaging_type.id` (Guess: standard Odoo packaging type link)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag; check if the source system uses a hard-delete policy or if records are filtered by an `active` column not present in this extract.
- **Data Quality:** The `qty` column is `NUMERIC` and may contain varying precision; ensure casting is handled if performing aggregations.
- **Sensitivity:** No direct PII is present, but `create_uid` and `write_uid` link to internal user identities.