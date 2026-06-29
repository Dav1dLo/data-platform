# Fully Qualified Name: DWH.FactPurchaseOrderLine

## Description
This fact table captures the granular details of purchase order line items, providing a record of procurement activities. It enables analysis of ordered versus received quantities, total spend per supplier and product, and procurement volume trends over time.

## Grain
One row per purchase order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DWH | PurchaseOrderLineSK | PK | bigint | bigint | Surrogate key generated via sequence. | |
| DWH | ProductSK | FK | bigint | bigint | Join to [DWH.DimProduct](../DataWarehouse/Dimension/DWH.DimProduct.md) on product_id. | |
| DWH | WarehouseSK | FK | integer | integer | Join to [DWH.DimWarehouse](../DataWarehouse/Dimension/DWH.DimWarehouse.md) on warehouse_id. | |
| DWH | SupplierSK | FK | bigint | bigint | Join to [DWH.DimSupplier](../DataWarehouse/Dimension/DWH.DimSupplier.md) on partner_id. | |
| DWH | CurrencySK | FK | integer | integer | Join to [DWH.DimCurrency](../DataWarehouse/Dimension/DWH.DimCurrency.md) on currency_id. | |
| DWH | OrderDateSK | FK | integer | integer | Join to [DWH.DimDate](../DataWarehouse/Dimension/DWH.DimDate.md) on order_date. | |
| DWH | PurchaseOrderLineID | DD | integer | integer | Source `public.purchase_order_line.id`. | |
| DWH | QuantityOrdered | ADD | numeric(18,6) | numeric(18,6) | Source `public.purchase_order_line.product_qty`. | sum |
| DWH | QuantityReceived | ADD | numeric(18,6) | numeric(18,6) | Source `public.purchase_order_line.qty_received`. | sum |
| DWH | UnitPrice | NON | numeric(18,6) | numeric(18,6) | Source `public.purchase_order_line.price_unit`. | average |
| DWH | TotalAmount | ADD | numeric(18,6) | numeric(18,6) | Source `public.purchase_order_line.price_subtotal`. | sum |
| DWH | CreatedAt | TC | timestamp | timestamp | Source `public.purchase_order_line.create_date`. | |

## Transformation Logic
The table is populated by extracting data from `public.purchase_order_line`. Surrogate keys are resolved by joining to the respective dimension tables based on the natural keys present in the staging table. The `OrderDateSK` is derived from the `date_order` field in the source.

## Lineage
- Reads from: [public.purchase_order_line](../Staging/public.purchase_order_line.md)
- Reads from: [DWH.DimProduct](../DataWarehouse/Dimension/DWH.DimProduct.md)
- Reads from: [DWH.DimWarehouse](../DataWarehouse/Dimension/DWH.DimWarehouse.md)
- Reads from: [DWH.DimSupplier](../DataWarehouse/Dimension/DWH.DimSupplier.md)
- Reads from: [DWH.DimCurrency](../DataWarehouse/Dimension/DWH.DimCurrency.md)
- Reads from: [DWH.DimDate](../DataWarehouse/Dimension/DWH.DimDate.md)

## Notes
- `QuantityOrdered` and `QuantityReceived` are additive measures.
- `UnitPrice` is a non-additive measure; it should be averaged when analyzing across multiple lines.
- `TotalAmount` is an additive measure representing the line subtotal.
- Ensure that `DimSupplier` and `DimDate` are implemented to support the required joins.