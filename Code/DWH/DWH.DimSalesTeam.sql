-- Work Item: ad-hoc
-- Task: DWH.DimSalesTeam
-- Spec: DWH.DimSalesTeam
-- Version: 1
-- Generated: 2026-07-01T14:19:39.673710+00:00
-- Notes: Initial generation of DWH.DimSalesTeam with SCD2 logic.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimSalesTeam" (
    "SalesTeamSK"      integer GENERATED ALWAYS AS IDENTITY,
    "SalesTeamBK"      integer NOT NULL,
    "TeamName"         varchar(255),
    "IsActive"         boolean,
    "UseLeads"         boolean,
    "UseOpportunities" boolean,
    "InvoicedTarget"   numeric(38,6),
    "TeamLeaderID"     integer,
    "CompanyID"        integer,
    "AliasID"          integer,
    "AssignmentOptOut" boolean,
    "AssignmentDomain" varchar,
    "Sequence"         integer,
    "Color"            integer,
    "CreatedAt"        timestamp,
    "UpdatedAt"        timestamp,
    "EffectiveDate"    timestamptz NOT NULL,
    "ExpiryDate"       timestamptz,
    "IsCurrent"        boolean NOT NULL DEFAULT true,
    "CreatedDate"      timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT "PK_DimSalesTeam" PRIMARY KEY ("SalesTeamSK")
);

-- Add missing columns if any
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "SalesTeamSK" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "SalesTeamBK" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "TeamName" varchar(255);
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "IsActive" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "UseLeads" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "UseOpportunities" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "InvoicedTarget" numeric(38,6);
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "TeamLeaderID" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "CompanyID" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "AliasID" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "AssignmentOptOut" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "AssignmentDomain" varchar;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "Sequence" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "Color" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "CreatedAt" timestamp;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "UpdatedAt" timestamp;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "EffectiveDate" timestamptz;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "ExpiryDate" timestamptz;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "IsCurrent" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "CreatedDate" timestamptz;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimSalesTeam_CurrentBusinessKey"
    ON "DWH"."DimSalesTeam" ("SalesTeamBK")
    WHERE "IsCurrent";

INSERT INTO "DWH"."DimSalesTeam" (
    "SalesTeamSK", "SalesTeamBK", "TeamName", "IsActive", "UseLeads", "UseOpportunities", "InvoicedTarget", "TeamLeaderID", "CompanyID", "AliasID", "AssignmentOptOut", "AssignmentDomain", "Sequence", "Color", "CreatedAt", "UpdatedAt", "EffectiveDate", "ExpiryDate", "IsCurrent", "CreatedDate"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1, -1, 'Unknown', false, false, false, 0, -1, -1, -1, false, 'Unknown', -1, -1, '1900-01-01 00:00:00', '1900-01-01 00:00:00', '1900-01-01 00:00:00+00', NULL, true, now()
)
ON CONFLICT ("SalesTeamSK") DO NOTHING;

DO $$
DECLARE
    v_now timestamptz := clock_timestamp();
BEGIN
    UPDATE "DWH"."DimSalesTeam" AS d
    SET "ExpiryDate" = v_now - interval '1 second',
        "IsCurrent"  = false
    FROM "public"."crm_team" AS s
    WHERE d."SalesTeamBK" = s."id"
      AND d."IsCurrent"
      AND EXISTS (
          SELECT d."TeamName"
          EXCEPT
          SELECT (s."name"->>'en_US')::varchar(255)
      );

    INSERT INTO "DWH"."DimSalesTeam" (
        "SalesTeamBK", "TeamName", "IsActive", "UseLeads", "UseOpportunities", "InvoicedTarget", "TeamLeaderID", "CompanyID", "AliasID", "AssignmentOptOut", "AssignmentDomain", "Sequence", "Color", "CreatedAt", "UpdatedAt", "EffectiveDate", "ExpiryDate", "IsCurrent", "CreatedDate"
    )
    SELECT
        s."id", (s."name"->>'en_US')::varchar(255), s."active", s."use_leads", s."use_opportunities", s."invoiced_target"::numeric(38,6), s."user_id", s."company_id", s."alias_id", s."assignment_optout", s."assignment_domain", s."sequence", s."color", s."create_date", s."write_date", v_now, NULL, true, v_now
    FROM "public"."crm_team" AS s
    WHERE NOT EXISTS (
        SELECT 1
        FROM "DWH"."DimSalesTeam" AS d
        WHERE d."SalesTeamBK" = s."id"
          AND d."IsCurrent"
    );
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END $$;