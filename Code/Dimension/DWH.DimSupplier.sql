-- Work Item: ad-hoc
-- Task: DWH.DimSupplier
-- Spec: DWH.DimSupplier
-- Version: 1
-- Generated: 2026-06-29T15:07:28.310734+00:00
-- Notes: Initial generation of DWH.DimSupplier using SCD Type 1 upsert pattern.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimSupplier" (
    "SupplierSK"              bigint GENERATED ALWAYS AS IDENTITY,
    "SupplierID"              integer NOT NULL,
    "SupplierName"            varchar(255),
    "SupplierReference"       varchar(255),
    "TaxIdentificationNumber" varchar(64),
    "SupplierRank"            integer,
    "IsCompany"               boolean,
    "City"                    varchar(128),
    "CountryID"               integer,
    "Email"                   varchar(255),
    "ActiveStatus"            boolean,
    CONSTRAINT "PK_DimSupplier" PRIMARY KEY ("SupplierSK")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimSupplier_SupplierID" ON "DWH"."DimSupplier" ("SupplierID");

INSERT INTO "DWH"."DimSupplier" (
    "SupplierID", "SupplierName", "SupplierReference", "TaxIdentificationNumber", 
    "SupplierRank", "IsCompany", "City", "CountryID", "Email", "ActiveStatus"
)
SELECT 
    "id", "name", "ref", "vat", "supplier_rank", "is_company", "city", "country_id", "email", "active"
FROM "public"."res_partner"
WHERE "supplier_rank" > 0 AND "active" = true
ON CONFLICT ("SupplierID") DO UPDATE SET
    "SupplierName" = EXCLUDED."SupplierName",
    "SupplierReference" = EXCLUDED."SupplierReference",
    "TaxIdentificationNumber" = EXCLUDED."TaxIdentificationNumber",
    "SupplierRank" = EXCLUDED."SupplierRank",
    "IsCompany" = EXCLUDED."IsCompany",
    "City" = EXCLUDED."City",
    "CountryID" = EXCLUDED."CountryID",
    "Email" = EXCLUDED."Email",
    "ActiveStatus" = EXCLUDED."ActiveStatus";