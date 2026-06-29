-- Work Item: ad-hoc
-- Task: DWH.DimWarehouse
-- Spec: DWH.DimWarehouse.md
-- Version: 1
-- Generated: 2026-06-29T13:21:02.005724+00:00
-- Notes: Initial generation of DWH.DimWarehouse using SCD Type 1 upsert pattern.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimWarehouse" (
    "WarehouseSK"    integer GENERATED ALWAYS AS IDENTITY,
    "WarehouseID"    integer NOT NULL,
    "WarehouseName"  varchar,
    "WarehouseCode"  varchar(5),
    "ReceptionSteps" varchar,
    "DeliverySteps"  varchar,
    "IsActive"       boolean,
    CONSTRAINT "PK_DimWarehouse" PRIMARY KEY ("WarehouseSK")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimWarehouse_WarehouseCode"
    ON "DWH"."DimWarehouse" ("WarehouseCode");

INSERT INTO "DWH"."DimWarehouse" (
    "WarehouseID", "WarehouseName", "WarehouseCode", "ReceptionSteps", "DeliverySteps", "IsActive"
)
SELECT 
    s."id", s."name", s."code", s."reception_steps", s."delivery_steps", s."active"
FROM "public"."stock_warehouse" AS s
ON CONFLICT ("WarehouseCode") DO UPDATE
SET 
    "WarehouseID"    = EXCLUDED."WarehouseID",
    "WarehouseName"  = EXCLUDED."WarehouseName",
    "ReceptionSteps" = EXCLUDED."ReceptionSteps",
    "DeliverySteps"  = EXCLUDED."DeliverySteps",
    "IsActive"       = EXCLUDED."IsActive";