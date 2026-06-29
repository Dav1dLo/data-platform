-- Work Item: ad-hoc
-- Task: DWH.FactSalesOrderLine
-- Spec: DWH.FactSalesOrderLine
-- Version: 1
-- Generated: 2026-06-29T13:21:21.102398+00:00
-- Notes: Initial generation of FactSalesOrderLine table and load logic.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."FactSalesOrderLine" (
    "sales_order_line_sk" bigint GENERATED ALWAYS AS IDENTITY,
    "order_id_dd"         integer       NOT NULL,
    "product_fk"          bigint        NOT NULL DEFAULT -1,
    "customer_fk"         bigint        NOT NULL DEFAULT -1,
    "currency_fk"         bigint        NOT NULL DEFAULT -1,
    "sales_team_fk"       bigint        NOT NULL DEFAULT -1,
    "warehouse_fk"        bigint        NOT NULL DEFAULT -1,
    "qty_ordered"         numeric(18,4) NOT NULL,
    "qty_delivered"       numeric(18,4) NOT NULL,
    "qty_invoiced"        numeric(18,4) NOT NULL,
    "unit_price"          numeric(18,4),
    "discount_pct"        numeric(18,4),
    "net_revenue"         numeric(18,4) NOT NULL,
    "tax_amount"          numeric(18,4) NOT NULL,
    "gross_revenue"       numeric(18,4) NOT NULL,
    "created_at"          timestamp     NOT NULL,
    CONSTRAINT "PK_FactSalesOrderLine" PRIMARY KEY ("sales_order_line_sk")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_FactSalesOrderLine_Grain" ON "DWH"."FactSalesOrderLine" ("order_id_dd");

CREATE INDEX IF NOT EXISTS "IX_FactSalesOrderLine_product_fk" ON "DWH"."FactSalesOrderLine" ("product_fk");
CREATE INDEX IF NOT EXISTS "IX_FactSalesOrderLine_customer_fk" ON "DWH"."FactSalesOrderLine" ("customer_fk");
CREATE INDEX IF NOT EXISTS "IX_FactSalesOrderLine_currency_fk" ON "DWH"."FactSalesOrderLine" ("currency_fk");
CREATE INDEX IF NOT EXISTS "IX_FactSalesOrderLine_sales_team_fk" ON "DWH"."FactSalesOrderLine" ("sales_team_fk");
CREATE INDEX IF NOT EXISTS "IX_FactSalesOrderLine_warehouse_fk" ON "DWH"."FactSalesOrderLine" ("warehouse_fk");

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactSalesOrderLine_Product') THEN
        ALTER TABLE "DWH"."FactSalesOrderLine" ADD CONSTRAINT "FK_FactSalesOrderLine_Product" FOREIGN KEY ("product_fk") REFERENCES "DWH"."DimProduct" ("product_sk");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactSalesOrderLine_Customer') THEN
        ALTER TABLE "DWH"."FactSalesOrderLine" ADD CONSTRAINT "FK_FactSalesOrderLine_Customer" FOREIGN KEY ("customer_fk") REFERENCES "DWH"."DimCustomer" ("customer_sk");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactSalesOrderLine_Currency') THEN
        ALTER TABLE "DWH"."FactSalesOrderLine" ADD CONSTRAINT "FK_FactSalesOrderLine_Currency" FOREIGN KEY ("currency_fk") REFERENCES "DWH"."DimCurrency" ("currency_sk");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactSalesOrderLine_SalesTeam') THEN
        ALTER TABLE "DWH"."FactSalesOrderLine" ADD CONSTRAINT "FK_FactSalesOrderLine_SalesTeam" FOREIGN KEY ("sales_team_fk") REFERENCES "DWH"."DimSalesTeam" ("sales_team_sk");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactSalesOrderLine_Warehouse') THEN
        ALTER TABLE "DWH"."FactSalesOrderLine" ADD CONSTRAINT "FK_FactSalesOrderLine_Warehouse" FOREIGN KEY ("warehouse_fk") REFERENCES "DWH"."DimWarehouse" ("warehouse_sk");
    END IF;
END $$;

INSERT INTO "DWH"."FactSalesOrderLine" (
    "order_id_dd", "product_fk", "customer_fk", "currency_fk", "sales_team_fk", "warehouse_fk",
    "qty_ordered", "qty_delivered", "qty_invoiced", "unit_price", "discount_pct", "net_revenue", "tax_amount", "gross_revenue", "created_at"
)
SELECT
    sol."order_id",
    coalesce(dp."product_sk", -1),
    coalesce(dc."customer_sk", -1),
    coalesce(dcur."currency_sk", -1),
    coalesce(dst."sales_team_sk", -1),
    coalesce(dw."warehouse_sk", -1),
    sol."product_uom_qty", sol."qty_delivered", sol."qty_invoiced", sol."price_unit", sol."discount", sol."price_subtotal", sol."price_tax", sol."price_total", sol."create_date"
FROM "public"."sale_order_line" AS sol
JOIN "public"."sale_order" AS so ON sol."order_id" = so."id"
LEFT JOIN "DWH"."DimProduct" AS dp ON sol."product_id" = dp."product_id"
LEFT JOIN "DWH"."DimCustomer" AS dc ON so."partner_id" = dc."customer_id"
LEFT JOIN "DWH"."DimCurrency" AS dcur ON sol."currency_id" = dcur."currency_id"
LEFT JOIN "DWH"."DimSalesTeam" AS dst ON so."team_id" = dst."sales_team_id"
LEFT JOIN "DWH"."DimWarehouse" AS dw ON sol."warehouse_id" = dw."warehouse_id"
ON CONFLICT ("order_id_dd") DO UPDATE
SET "product_fk" = EXCLUDED."product_fk",
    "customer_fk" = EXCLUDED."customer_fk",
    "currency_fk" = EXCLUDED."currency_fk",
    "sales_team_fk" = EXCLUDED."sales_team_fk",
    "warehouse_fk" = EXCLUDED."warehouse_fk",
    "qty_ordered" = EXCLUDED."qty_ordered",
    "qty_delivered" = EXCLUDED."qty_delivered",
    "qty_invoiced" = EXCLUDED."qty_invoiced",
    "unit_price" = EXCLUDED."unit_price",
    "discount_pct" = EXCLUDED."discount_pct",
    "net_revenue" = EXCLUDED."net_revenue",
    "tax_amount" = EXCLUDED."tax_amount",
    "gross_revenue" = EXCLUDED."gross_revenue";