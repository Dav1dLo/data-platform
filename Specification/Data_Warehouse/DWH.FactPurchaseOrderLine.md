# Fully Qualified Name: DWH.FactPurchaseOrderLine

## Description
This fact table captures the procurement activity at the line-item level, enabling detailed spend analysis, vendor performance tracking, and comparison of ordered versus received quantities.

## Grain
One row per purchase order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DWH | PurchaseOrderLineSK | PK | bigint | 8 | Surrogate key generated as a hash or sequence. | |
| DWH | ProductKey | FK | integer | integer | Lookup from DWH.DimProduct.ProductKey where DWH.DimProduct.ProductBK = public.purchase_order_line.product_id. | |
| DWH | OrderDateKey | FK | integer | 8 | Lookup from DWH.DimDate.DateKey where DWH.DimDate.FullDate = public.purchase_order_line.create_date::date. | |
| DWH | PurchaseOrderLineBK | DD | integer | integer | Direct mapping from public.purchase_order_line.id. | |
| DWH | QtyOrdered | ADD | numeric | numeric(18,4) | Direct mapping from public.purchase_order_line.product_qty. | sum |
| DWH | QtyReceived | ADD | numeric | numeric(18,4) | Direct mapping from public.purchase_order_line.qty_received. | sum |
| DWH | QtyInvoiced | ADD | numeric | numeric(18,4) | Direct mapping from public.purchase_order_line.qty_invoiced. | sum |
| DWH | PriceUnit | NON | numeric | numeric(18,4) | Direct mapping from public.purchase_order_line.price_unit. | |
| DWH | PriceSubtotal | ADD | numeric | numeric(18,4) | Direct mapping from public.purchase_order_line.price_subtotal. | sum |
| DWH | PriceTotal | ADD | numeric | numeric(18,4) | Direct mapping from public.purchase_order_line.price_total. | sum |

## Transformation Logic
The table is populated by selecting records from `public.purchase_order_line`. Surrogate keys are resolved by joining to `DWH.DimProduct` on `product_id` and `DWH.DimDate` on the `create_date` of the purchase order line. Measures are mapped directly from the source table, maintaining the precision defined in the source system.

## Lineage
- Reads from: [public.purchase_order_line](../Staging/public.purchase_order_line.md)
- Reads from: [DWH.DimProduct](../Data Warehouse/Dimension/DWH.DimProduct.md)
- Reads from: [DWH.DimDate](../Data Warehouse/Dimension/DWH.DimDate.md)

## Notes
- `PriceUnit` is marked as non-additive because summing unit prices across multiple lines is generally not meaningful.
- `QtyOrdered`, `QtyReceived`, and `QtyInvoiced` are additive measures.
- Future iterations should consider adding a `DimVendor` and `DimPurchaseOrder` for more granular analysis.