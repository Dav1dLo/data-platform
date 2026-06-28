-- Work Item: ad-hoc
-- Task: DimSalesPerson
-- Spec: Specification/Dimension/DimSalesPerson.md
-- Version: 2
-- Generated: 2026-06-28T10:45:19.390868+00:00
-- Notes: Refactored to Type 1 upsert pattern using ON CONFLICT and corrected partner name resolution.

CREATE SCHEMA IF NOT EXISTS Dimension;

CREATE TABLE IF NOT EXISTS Dimension.DimSalesPerson (
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
    ON Dimension.DimSalesPerson (SalesPersonID);

INSERT INTO Dimension.DimSalesPerson (
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