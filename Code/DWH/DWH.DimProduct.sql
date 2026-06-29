-- Work Item: ad-hoc
-- Task: DWH.DimProduct
-- Spec: DWH.DimProduct.md
-- Version: 1
-- Generated: 2026-06-29T08:55:51.721503+00:00
-- Notes: Initial generation of DWH.DimProduct dimension table.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimProduct" (
    "ProductSK"         bigint GENERATED ALWAYS AS IDENTITY,
    "ProductId"         integer NOT NULL,
    "ProductTemplateId" integer NOT NULL,
    "SKU"               varchar(255),
    "Barcode"           varchar(255),
    "Volume"            numeric(18,6),
    "Weight"            numeric(18,6),
    "IsActive"          boolean,
    "CreatedAt"         timestamp,
    "UpdatedAt"         timestamp,
    CONSTRAINT "PK_DimProduct" PRIMARY KEY ("ProductSK")
);

CREATE INDEX IF NOT EXISTS "IX_DimProduct_ProductId" ON "DWH"."DimProduct" ("ProductId");

INSERT INTO "DWH"."DimProduct" (
    "ProductId", "ProductTemplateId", "SKU", "Barcode", "Volume", "Weight", "IsActive", "CreatedAt", "UpdatedAt"
)
SELECT
    s."id", s."product_tmpl_id", s."default_code", s."barcode", s."volume", s."weight", s."active", s."create_date", s."write_date"
FROM "public"."product_product" AS s
ON CONFLICT ("ProductId") DO UPDATE SET
    "ProductTemplateId" = EXCLUDED."ProductTemplateId",
    "SKU" = EXCLUDED."SKU",
    "Barcode" = EXCLUDED."Barcode",
    "Volume" = EXCLUDED."Volume",
    "Weight" = EXCLUDED."Weight",
    "IsActive" = EXCLUDED."IsActive",
    "CreatedAt" = EXCLUDED."CreatedAt",
    "UpdatedAt" = EXCLUDED."UpdatedAt";