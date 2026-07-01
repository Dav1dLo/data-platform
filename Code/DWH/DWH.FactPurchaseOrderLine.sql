-- Work Item: ad-hoc
-- Task: DWH.FactPurchaseOrderLine
-- Spec: DWH.FactPurchaseOrderLine
-- Version: 1
-- Generated: 2026-07-01T14:18:09.388102+00:00
-- Notes: Initial generation of DWH.FactPurchaseOrderLine with idempotent upsert logic.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."FactPurchaseOrderLine" (
    "PurchaseOrderLineSK" bigint GENERATED ALWAYS AS IDENTITY,
    "ProductKey"          int           NOT NULL DEFAULT -1,
    "OrderDateKey"        int           NOT NULL DEFAULT -1,
    "PurchaseOrderLineBK" int           NOT NULL,
    "QtyOrdered"          numeric(18,4) NOT NULL,
    "QtyReceived"         numeric(18,4) NOT NULL,
    "QtyInvoiced"         numeric(18,4) NOT NULL,
    "PriceUnit"           numeric(18,4),
    "PriceSubtotal"       numeric(18,4) NOT NULL,
    "PriceTotal"          numeric(18,4) NOT NULL,
    CONSTRAINT "PK_FactPurchaseOrderLine" PRIMARY KEY ("PurchaseOrderLineSK")
);

-- Ensure columns exist (additive-only schema evolution)
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "PurchaseOrderLineSK" bigint GENERATED ALWAYS AS IDENTITY;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "ProductKey" int NOT NULL DEFAULT -1;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "OrderDateKey" int NOT NULL DEFAULT -1;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "PurchaseOrderLineBK" int NOT NULL;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "QtyOrdered" numeric(18,4) NOT NULL;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "QtyReceived" numeric(18,4) NOT NULL;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "QtyInvoiced" numeric(18,4) NOT NULL;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "PriceUnit" numeric(18,4);
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "PriceSubtotal" numeric(18,4) NOT NULL;
ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD COLUMN IF NOT EXISTS "PriceTotal" numeric(18,4) NOT NULL;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_FactPurchaseOrderLine_Grain" ON "DWH"."FactPurchaseOrderLine" ("PurchaseOrderLineBK");

CREATE INDEX IF NOT EXISTS "IX_FactPurchaseOrderLine_ProductKey" ON "DWH"."FactPurchaseOrderLine" ("ProductKey");
CREATE INDEX IF NOT EXISTS "IX_FactPurchaseOrderLine_OrderDateKey" ON "DWH"."FactPurchaseOrderLine" ("OrderDateKey");

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactPurchaseOrderLine_Product') THEN
        ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD CONSTRAINT "FK_FactPurchaseOrderLine_Product" FOREIGN KEY ("ProductKey") REFERENCES "DWH"."DimProduct" ("ProductKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactPurchaseOrderLine_Date') THEN
        ALTER TABLE "DWH"."FactPurchaseOrderLine" ADD CONSTRAINT "FK_FactPurchaseOrderLine_Date" FOREIGN KEY ("OrderDateKey") REFERENCES "DWH"."DimDate" ("DateKey");
    END IF;
END $$;

INSERT INTO "DWH"."FactPurchaseOrderLine" (
    "ProductKey", "OrderDateKey", "PurchaseOrderLineBK", 
    "QtyOrdered", "QtyReceived", "QtyInvoiced", 
    "PriceUnit", "PriceSubtotal", "PriceTotal"
)
SELECT
    coalesce(dp."ProductKey", -1),
    coalesce(to_char(s."create_date", 'YYYYMMDD')::int, -1),
    s."id",
    coalesce(s."product_qty", 0),
    coalesce(s."qty_received", 0),
    coalesce(s."qty_invoiced", 0),
    s."price_unit",
    coalesce(s."price_subtotal", 0),
    coalesce(s."price_total", 0)
FROM "public"."purchase_order_line" AS s
LEFT JOIN "DWH"."DimProduct" AS dp ON dp."ProductBK" = s."product_id"
ON CONFLICT ("PurchaseOrderLineBK") DO UPDATE
SET "ProductKey"    = EXCLUDED."ProductKey",
    "OrderDateKey"  = EXCLUDED."OrderDateKey",
    "QtyOrdered"    = EXCLUDED."QtyOrdered",
    "QtyReceived"   = EXCLUDED."QtyReceived",
    "QtyInvoiced"   = EXCLUDED."QtyInvoiced",
    "PriceUnit"     = EXCLUDED."PriceUnit",
    "PriceSubtotal" = EXCLUDED."PriceSubtotal",
    "PriceTotal"    = EXCLUDED."PriceTotal";