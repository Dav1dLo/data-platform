# Fully Qualified Name: DWH.FactSaleOrderLine

## Description
This fact table captures the granular details of individual sales order lines, providing a comprehensive view of sales performance. It enables analysis of revenue, quantity, and discounts across dimensions such as product, customer, sales team, and time.

## Grain
One row per sales order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DWH | SaleOrderLineSK | PK | bigint | 8 bytes | Surrogate key generated as a hash of SaleOrderID and LineID. | |
| DWH | DateKey | FK | integer | 8 | Lookup from DWH.DimDate.DateKey where DWH.DimDate.FullDate = public.sale_order.date_order::date. | |
| DWH | ProductKey | FK | integer | integer | Lookup from DWH.DimProduct.ProductKey where DWH.DimProduct.ProductBK = public.sale_order_line.product_id. | |
| DWH | CustomerKey | FK | integer | 4 bytes | Lookup from DWH.DimCustomer.CustomerKey where DWH.DimCustomer.CustomerBK = public.sale_order.partner_id. | |
| DWH | SalesTeamSK | FK | integer | integer | Lookup from DWH.DimSalesTeam.SalesTeamSK where DWH.DimSalesTeam.SalesTeamBK = public.sale_order.team_id. | |
| DWH | SaleOrderID | DD | integer | 4 bytes | Pass-through from public.sale_order.id. | |
| DWH | Quantity | ADD | numeric(18,4) | 18,4 | Pass-through from public.sale_order_line.product_uom_qty. | SUM |
| DWH | UnitPrice | NON | numeric(18,4) | 18,4 | Pass-through from public.sale_order_line.price_unit. | |
| DWH | DiscountAmount | ADD | numeric(18,4) | 18,4 | Calculated as (price_unit * product_uom_qty) * (discount / 100). | SUM |
| DWH | NetRevenue | ADD | numeric(38,8) | 38,8 | Calculated as (product_uom_qty * price_unit) - DiscountAmount. | SUM |

## Transformation Logic
The table is populated by joining `public.sale_order_line` with `public.sale_order` on `order_id`. Surrogate keys are resolved by joining to the respective dimension tables (`DWH.DimProduct`, `DWH.DimCustomer`, `DWH.DimSalesTeam`, `DWH.DimDate`) using the natural keys from the staging tables. Measures are calculated at the line level to ensure additive properties for reporting.

## Lineage
- Reads from: [public.sale_order](../Staging/public.sale_order.md)
- Reads from: [public.sale_order_line](../Staging/public.sale_order_line.md)
- Reads from: [DWH.DimProduct](../Data Warehouse/Dimension/DWH.DimProduct.md)
- Reads from: [DWH.DimCustomer](../Data Warehouse/Dimension/DWH.DimCustomer.md)
- Reads from: [DWH.DimSalesTeam](../Data Warehouse/Dimension/DWH.DimSalesTeam.md)
- Reads from: [DWH.DimDate](../Data Warehouse/Dimension/DWH.DimDate.md)

## Notes
- `NetRevenue` precision is set to `numeric(38,8)` to prevent overflow during aggregation of large volumes of sales data.
- `SaleOrderID` is included as a degenerate dimension to allow for drill-through to the source order level.
- `UnitPrice` is marked as non-additive because summing unit prices across multiple lines is generally not meaningful; use `NetRevenue` for financial totals.