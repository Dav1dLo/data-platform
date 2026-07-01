-- Work Item: ad-hoc
-- Task: DWH.DimSalesTeam
-- Spec: DWH.DimSalesTeam.md
-- Version: 1
-- Generated: 2026-07-01T09:20:20.421701+00:00
-- Notes: Initial generation of DWH.DimSalesTeam dimension table.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimSalesTeam" (
    "SalesTeamSK"    integer GENERATED ALWAYS AS IDENTITY,
    "SalesTeamBK"    integer NOT NULL,
    "TeamName"       varchar(255),
    "IsActive"       boolean,
    "UseLeads"       boolean,
    "UseOpportunities" boolean,
    "InvoicedTarget" numeric(38,6),
    CONSTRAINT "PK_DimSalesTeam" PRIMARY KEY ("SalesTeamSK")
);

-- Ensure columns exist (additive-only schema evolution)
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "SalesTeamBK" integer;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "TeamName" varchar(255);
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "IsActive" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "UseLeads" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "UseOpportunities" boolean;
ALTER TABLE "DWH"."DimSalesTeam" ADD COLUMN IF NOT EXISTS "InvoicedTarget" numeric(38,6);

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimSalesTeam_SalesTeamBK" ON "DWH"."DimSalesTeam" ("SalesTeamBK");

INSERT INTO "DWH"."DimSalesTeam" (
    "SalesTeamSK", "SalesTeamBK", "TeamName", "IsActive", "UseLeads", "UseOpportunities", "InvoicedTarget"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1, -1, 'Unknown', false, false, false, 0
)
ON CONFLICT ("SalesTeamSK") DO NOTHING;

INSERT INTO "DWH"."DimSalesTeam" (
    "SalesTeamBK", "TeamName", "IsActive", "UseLeads", "UseOpportunities", "InvoicedTarget"
)
SELECT
    s."id"::integer,
    (s."name"::jsonb ->> 'en_US')::varchar(255),
    s."active"::boolean,
    s."use_leads"::boolean,
    s."use_opportunities"::boolean,
    s."invoiced_target"::numeric(38,6)
FROM "public"."crm_team" AS s
ON CONFLICT ("SalesTeamBK") DO UPDATE
SET
    "TeamName" = EXCLUDED."TeamName",
    "IsActive" = EXCLUDED."IsActive",
    "UseLeads" = EXCLUDED."UseLeads",
    "UseOpportunities" = EXCLUDED."UseOpportunities",
    "InvoicedTarget" = EXCLUDED."InvoicedTarget";