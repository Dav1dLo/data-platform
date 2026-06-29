-- Work Item: ad-hoc
-- Task: DWH.DimCurrency
-- Spec: DWH.DimCurrency.md
-- Version: 1
-- Generated: 2026-06-29T08:52:07.460814+00:00
-- Notes: Initial generation of DWH.DimCurrency using SCD Type 1 upsert pattern.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimCurrency" (
    "CurrencySK"      integer GENERATED ALWAYS AS IDENTITY,
    "CurrencyID"      integer NOT NULL,
    "CurrencyName"    varchar(255),
    "CurrencySymbol"  varchar(10),
    "ISONumericCode"  integer,
    "DecimalPlaces"   integer,
    "SymbolPosition"  varchar(20),
    "RoundingFactor"  numeric(18,6),
    "IsActive"        boolean,
    CONSTRAINT "PK_DimCurrency" PRIMARY KEY ("CurrencySK")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimCurrency_CurrencyID"
    ON "DWH"."DimCurrency" ("CurrencyID");

INSERT INTO "DWH"."DimCurrency" (
    "CurrencyID", "CurrencyName", "CurrencySymbol", "ISONumericCode", 
    "DecimalPlaces", "SymbolPosition", "RoundingFactor", "IsActive"
)
SELECT 
    s."id", s."name", s."symbol", s."iso_numeric", 
    s."decimal_places", s."position", s."rounding", s."active"
FROM "public"."res_currency" AS s
ON CONFLICT ("CurrencyID") DO UPDATE SET
    "CurrencyName"   = EXCLUDED."CurrencyName",
    "CurrencySymbol" = EXCLUDED."CurrencySymbol",
    "ISONumericCode" = EXCLUDED."ISONumericCode",
    "DecimalPlaces"  = EXCLUDED."DecimalPlaces",
    "SymbolPosition" = EXCLUDED."SymbolPosition",
    "RoundingFactor" = EXCLUDED."RoundingFactor",
    "IsActive"       = EXCLUDED."IsActive";