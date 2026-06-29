-- Work Item: ad-hoc
-- Task: DWH.DimCustomer
-- Spec: DWH.DimCustomer
-- Version: 1
-- Generated: 2026-06-29T08:55:36.230825+00:00
-- Notes: Initial generation of DWH.DimCustomer as an SCD1 dimension.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimCustomer" (
    "CustomerSK"      bigint GENERATED ALWAYS AS IDENTITY,
    "SourcePartnerID" integer NOT NULL,
    "CustomerName"    varchar(128),
    "IsCompany"       boolean,
    "Industry"        varchar(64),
    "CustomerCity"    varchar(128),
    "CustomerCountry" varchar(64),
    "CustomerVAT"     varchar(64),
    "CustomerType"    varchar(32),
    "IsActive"        boolean,
    CONSTRAINT "PK_DimCustomer" PRIMARY KEY ("CustomerSK")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimCustomer_SourcePartnerID" ON "DWH"."DimCustomer" ("SourcePartnerID");

INSERT INTO "DWH"."DimCustomer" (
    "SourcePartnerID", "CustomerName", "IsCompany", "Industry", "CustomerCity", 
    "CustomerCountry", "CustomerVAT", "CustomerType", "IsActive"
)
SELECT 
    "id", "name", "is_company", "industry_id", "city", 
    "country_id", "vat", "type", "active"
FROM "public"."res_partner"
WHERE "customer_rank" > 0
ON CONFLICT ("SourcePartnerID") DO UPDATE SET
    "CustomerName"    = EXCLUDED."CustomerName",
    "IsCompany"       = EXCLUDED."IsCompany",
    "Industry"        = EXCLUDED."Industry",
    "CustomerCity"    = EXCLUDED."CustomerCity",
    "CustomerCountry" = EXCLUDED."CustomerCountry",
    "CustomerVAT"     = EXCLUDED."CustomerVAT",
    "CustomerType"    = EXCLUDED."CustomerType",
    "IsActive"        = EXCLUDED."IsActive";