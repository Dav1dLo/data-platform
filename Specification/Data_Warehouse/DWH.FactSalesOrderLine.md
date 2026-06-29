# Fully Qualified Name: DWH.FactSalesOrderLine

## Description
This fact table captures the granular details of sales order line items, enabling analysis of sales performance, fulfillment efficiency, and revenue metrics. It serves as the central point for evaluating product-level sales, discount impacts, and warehouse fulfillment accuracy.

## Grain
One row per individual sales order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| DWH | sales_order_line_sk | PK | bigint | 8 bytes | Surrogate key generated during ETL load. | |
| DWH | order_id_dd | DD | integer | 32-bit integer | Pass-through from `public.sale_order_line.order_id`. | |
| DWH | product_fk | FK | bigint | 8 bytes | Resolved from `public.sale_order_line.product_id` to `DWH.DimProduct.product_sk`. | |
| DWH | customer_fk | FK | bigint | 8 bytes | Resolved from `public.sale_order.partner_id` to `DWH.DimCustomer.customer_sk`. | |
| DWH | currency_fk | FK | bigint | 8 bytes | Resolved from `public.sale_order_line.currency_id` to `DWH.DimCurrency.currency_sk`. | |
| DWH | sales_team_fk | FK | bigint | 8 bytes | Resolved from `public.sale_order.team_id` to `DWH.DimSalesTeam.sales_team_sk`. | |
| DWH | warehouse_fk | FK | bigint | 8 bytes | Resolved from `public.sale_order_line.warehouse_id` to `DWH.DimWarehouse.warehouse_sk`. | |
| DWH | qty_ordered | ADD | numeric(18,4) | `public.sale_order_line.product_uom_qty` | Pass-through from `public.sale_order_line.product_uom_qty`. | sum |
| DWH | qty_delivered | ADD | numeric(18,4) | `public.sale_order_line.qty_delivered` | Pass-through from `public.sale_order_line.qty_delivered`. | sum |
| DWH | qty_invoiced | ADD | numeric(18,4) | `public.sale_order_line.qty_invoiced` | Pass-through from `public.sale_order_line.qty_invoiced`. | sum |
| DWH | unit_price | NON | numeric(18,4) | `public.sale_order_line.price_unit` | Pass-through from `public.sale_order_line.price_unit`. | average |
| DWH | discount_pct | NON | numeric(18,4) | `public.sale_order_line.discount` | Pass-through from `public.sale_order_line.discount`. | average |
| DWH | net_revenue | ADD | numeric(18,4) | `public.sale_order_line.price_subtotal` | Pass-through from `public.sale_order_line.price_subtotal`. | sum |
| DWH | tax_amount | ADD | numeric(18,4) | `public.sale_order_line.price_tax` | Pass-through from `public.sale_order_line.price_tax`. | sum |
| DWH | gross_revenue | ADD | numeric(18,4) | `public.sale_order_line.price_total` | Pass-through from `public.sale_order_line.price_total`. | sum |
| DWH | created_at | TC | timestamp | 8 bytes | Pass-through from `public.sale_order_line.create_date`. | |

## Transformation Logic
The table is populated by joining `public.sale_order_line` with `public.sale_order` on `order_id`. Surrogate keys are resolved by looking up the natural keys from the staging tables against the corresponding dimension tables:
- `product_fk` joins `public.sale_order_line.product_id` to `DWH.DimProduct`.
- `customer_fk` joins `public.sale_order.partner_id` to `DWH.DimCustomer`.
- `currency_fk` joins `public.sale_order_line.currency_id` to `DWH.DimCurrency`.
- `sales_team_fk` joins `public.sale_order.team_id` to `DWH.DimSalesTeam`.
- `warehouse_fk` joins `public.sale_order_line.warehouse_id` to `DWH.DimWarehouse`.

## Lineage
- Reads from: [public.sale_order](../Staging/public.sale_order.md)
- Reads from: [public.sale_order_line](../Staging/public.sale_order_line.md)
- Reads from: [DWH.DimProduct](../DataWarehouse/DWH.DimProduct.md)
- Reads from: [DWH.DimCustomer](../DataWarehouse/DWH.DimCustomer.md)
- Reads from: [DWH.DimCurrency](../DataWarehouse/DWH.DimCurrency.md)
- Reads from: [DWH.DimSalesTeam](../DataWarehouse/DWH.DimSalesTeam.md)
- Reads from: [DWH.DimWarehouse](../DataWarehouse/DWH.DimWarehouse.md)

## Notes
- `qty_ordered`, `qty_delivered`, and `qty_invoiced` are additive measures.
- `unit_price` and `discount_pct` are non-additive and should be aggregated using averages or weighted averages in BI tools.
- The `order_id_dd` is included as a degenerate dimension to allow for easy drill-down to the source order header.
- Financial precision is set to `numeric(18,4)` to accommodate standard ERP financial precision requirements.