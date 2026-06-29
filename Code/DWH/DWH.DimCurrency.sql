-- Work Item: ad-hoc
-- Task: DWH.DimCurrency
-- Spec: DWH.DimCurrency.md
-- Version: 1
-- Generated: 2026-06-29T08:53:53.031516+00:00
-- Notes: Initial generation of DWH.DimCurrency dimension table.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimCurrency" (
    "CurrencySK"      int GENERATED ALWAYS AS IDENTITY,
    "CurrencyID"      integer NOT NULL,
    "CurrencyName"    varchar(255),
    "CurrencySymbol"  varchar(10),
    "ISONumericCode"  integer,
    "DecimalPlaces"   integer,
    "SymbolPositions" varchar(20),
    "RoundingFactor"  numeric(18,6),
    "IsActive"        boolean,
    "EffectiveDate"   timestamptz NOT NULL,
    "ExpiryDate"      timestamptz,
    "IsCurrent"       boolean NOT NULL DEFAULT true,
    "CreatedDate"     timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT "PK_DimCurrency" PRIMARY KEY ("CurrencySK")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimCurrency_CurrentBusinessKey"
    ON "DWH"."DimCurrency" ("CurrencyID")
    WHERE "IsCurrent";

DO $$
DECLARE
    v_now timestamptz := clock_timestamp();
BEGIN
    -- 1. Update Type 1 attributes (SCD1) and expire Type 2 attributes (SCD2)
    -- Note: SymbolPositions is tracked as SCD2, others as SCD1.
    UPDATE "DWH"."DimCurrency" AS d
    SET 
        "CurrencyName"    = s."name",
        "CurrencySymbol"  = s."symbol",
        "ISONumericCode"  = s."iso_numeric",
        "DecimalPlaces"   = s."decimal_places",
        "RoundingFactor"  = s."rounding",
        "IsActive"        = s."active",
        "ExpiryDate"      = CASE WHEN d."SymbolPositions" IS DISTINCT FROM s."position" THEN v_now - interval '1 second' ELSE d."ExpiryDate" END,
        "IsCurrent"       = CASE WHEN d."SymbolPositions" IS DISTINCT FROM s."position" THEN false ELSE d."IsCurrent" END
    FROM "public"."res_currency" AS s
    WHERE d."CurrencyID" = s."id"
      AND d."IsCurrent";

    -- 2. Insert new versions for SCD2 changes + brand-new keys
    INSERT INTO "DWH"."DimCurrency" (
        "CurrencyID", "CurrencyName", "CurrencySymbol", "ISONumericCode", 
        "DecimalPlaces", "SymbolPositions", "RoundingFactor", "IsActive",
        "EffectiveDate", "ExpiryDate", "IsCurrent", "CreatedDate"
    )
    SELECT
        s."id", s."name", s."symbol", s."iso_numeric", 
        s."decimal_places", s."position", s."rounding", s."active",
        v_now, NULL, true, v_now
    FROM "public"."res_currency" AS s
    WHERE NOT EXISTS (
        SELECT 1
        FROM "DWH"."DimCurrency" AS d
        WHERE d."CurrencyID" = s."id"
          AND d."IsCurrent"
    );

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END $$;