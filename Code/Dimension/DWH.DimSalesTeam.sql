-- Work Item: ad-hoc
-- Task: DWH.DimSalesTeam
-- Spec: DWH.DimSalesTeam
-- Version: 1
-- Generated: 2026-06-29T13:20:44.447521+00:00
-- Notes: Initial generation of DWH.DimSalesTeam using SCD Type 1 upsert pattern.

CREATE SCHEMA IF NOT EXISTS "DWH";

CREATE TABLE IF NOT EXISTS "DWH"."DimSalesTeam" (
    "SalesTeamSK"      integer GENERATED ALWAYS AS IDENTITY,
    "SalesTeamID"      integer NOT NULL,
    "TeamName"         varchar(255),
    "TeamLeaderID"     integer,
    "IsActive"         boolean,
    "UseLeads"         boolean,
    "UseOpportunities" boolean,
    "InvoicedTarget"   numeric(18,2),
    CONSTRAINT "PK_DimSalesTeam" PRIMARY KEY ("SalesTeamSK")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimSalesTeam_SalesTeamID"
    ON "DWH"."DimSalesTeam" ("SalesTeamID");

INSERT INTO "DWH"."DimSalesTeam" (
    "SalesTeamID", "TeamName", "TeamLeaderID", "IsActive", 
    "UseLeads", "UseOpportunities", "InvoicedTarget"
)
SELECT
    CAST(s."id" AS integer),
    CAST(s."name"->>'en_US' AS varchar(255)),
    CAST(s."user_id" AS integer),
    CAST(s."active" AS boolean),
    CAST(s."use_leads" AS boolean),
    CAST(s."use_opportunities" AS boolean),
    CAST(s."invoiced_target" AS numeric(18,2))
FROM "public"."crm_team" AS s
ON CONFLICT ("SalesTeamID") DO UPDATE
SET
    "TeamName"         = EXCLUDED."TeamName",
    "TeamLeaderID"     = EXCLUDED."TeamLeaderID",
    "IsActive"         = EXCLUDED."IsActive",
    "UseLeads"         = EXCLUDED."UseLeads",
    "UseOpportunities" = EXCLUDED."UseOpportunities",
    "InvoicedTarget"   = EXCLUDED."InvoicedTarget";