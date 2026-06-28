-- Work Item: ad-hoc
-- Task: ad-hoc spec generation
-- Spec: Specification/Dimension/DimSalesPerson.md
-- Version: 3
-- Generated: 2026-06-28T11:25:08.340835+00:00
-- Notes: Updated to DWH schema as per fully qualified name in spec; maintained Type 1 upsert logic.

CREATE SCHEMA IF NOT EXISTS DWH;

CREATE TABLE IF NOT EXISTS DWH.DimSalesPerson (
    SalesPersonKey      int GENERATED ALWAYS AS IDENTITY,
    SalesPersonID       int NOT NULL,
    SalesPersonName     varchar(255),
    SalesPersonLogin    varchar(255),
    SalesTeamID         int,
    CompanyID           int,
    IsActive            boolean,
    TargetSalesWon      int,
    TargetSalesDone     int,
    TargetSalesInvoiced int,
    IsPortalUser        boolean,
    CreatedDate         timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT PK_DimSalesPerson PRIMARY KEY (SalesPersonKey)
);

CREATE UNIQUE INDEX IF NOT EXISTS UK_DimSalesPerson_SalesPersonID
    ON DWH.DimSalesPerson (SalesPersonID);

INSERT INTO DWH.DimSalesPerson (
    SalesPersonID, SalesPersonName, SalesPersonLogin, SalesTeamID, 
    CompanyID, IsActive, TargetSalesWon, TargetSalesDone, 
    TargetSalesInvoiced, IsPortalUser
)
SELECT 
    u.id, 
    p.name, 
    u.login, 
    u.sale_team_id, 
    u.company_id, 
    u.active, 
    u.target_sales_won, 
    u.target_sales_done, 
    u.target_sales_invoiced, 
    u.share
FROM public.res_users u
LEFT JOIN public.res_partner p ON u.partner_id = p.id
ON CONFLICT (SalesPersonID) DO UPDATE SET
    SalesPersonName     = EXCLUDED.SalesPersonName,
    SalesPersonLogin    = EXCLUDED.SalesPersonLogin,
    SalesTeamID         = EXCLUDED.SalesTeamID,
    CompanyID           = EXCLUDED.CompanyID,
    IsActive            = EXCLUDED.IsActive,
    TargetSalesWon      = EXCLUDED.TargetSalesWon,
    TargetSalesDone     = EXCLUDED.TargetSalesDone,
    TargetSalesInvoiced = EXCLUDED.TargetSalesInvoiced,
    IsPortalUser        = EXCLUDED.IsPortalUser;