-- Work Item: ad-hoc
-- Task: ad-hoc spec generation
-- Spec: Specification/Dimension/DimSalesTeam.md
-- Version: 2
-- Generated: 2026-06-28T12:45:51.857911+00:00
-- Notes: Refined DDL/DML for idempotency and alignment with standard dimension patterns.

CREATE SCHEMA IF NOT EXISTS Dimension;

CREATE TABLE IF NOT EXISTS Dimension.DimSalesTeam (
    SalesTeamSK      int GENERATED ALWAYS AS IDENTITY,
    SalesTeamID      integer NOT NULL,
    TeamName         varchar(255),
    TeamLeaderUserID integer,
    IsActive         boolean,
    UseLeads         boolean,
    UseOpportunities boolean,
    InvoicedTarget   double precision,
    CompanyID        integer,
    CreatedAt        timestamp,
    UpdatedAt        timestamp,
    CONSTRAINT PK_DimSalesTeam PRIMARY KEY (SalesTeamSK)
);

CREATE UNIQUE INDEX IF NOT EXISTS UK_DimSalesTeam_SalesTeamID
    ON Dimension.DimSalesTeam (SalesTeamID);

INSERT INTO Dimension.DimSalesTeam (
    SalesTeamID, TeamName, TeamLeaderUserID, IsActive, UseLeads, 
    UseOpportunities, InvoicedTarget, CompanyID, CreatedAt, UpdatedAt
)
SELECT 
    id, (name->>'en_US')::varchar, user_id, active, use_leads, 
    use_opportunities, invoiced_target, company_id, create_date, write_date
FROM public.crm_team
ON CONFLICT (SalesTeamID) DO UPDATE 
SET 
    TeamName = EXCLUDED.TeamName,
    TeamLeaderUserID = EXCLUDED.TeamLeaderUserID,
    IsActive = EXCLUDED.IsActive,
    UseLeads = EXCLUDED.UseLeads,
    UseOpportunities = EXCLUDED.UseOpportunities,
    InvoicedTarget = EXCLUDED.InvoicedTarget,
    CompanyID = EXCLUDED.CompanyID,
    UpdatedAt = EXCLUDED.UpdatedAt;