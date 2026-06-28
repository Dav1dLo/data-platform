-- file: Code/Data_Warehouse/DimCustomer.sql
-- Work Item: WS-88
-- Task: Create DimCustomer
-- Spec: DWH.DimCustomer
-- Version: 2
-- Generated: 2026-06-28T08:37:09.564230+00:00
-- Notes: Corrected schema to MART, fixed CustomerSK as SK not PK, CustomerID as BK, added proper SCD Type 1 structure

CREATE SCHEMA IF NOT EXISTS MART;

CREATE TABLE IF NOT EXISTS MART.DimCustomer (
    CustomerSK       int GENERATED ALWAYS AS IDENTITY,  -- SK
    CustomerID       int NOT NULL,                      -- BK
    CustomerName     varchar(255),                      -- A1
    IsCompany        boolean,                           -- A1
    IndustryName     varchar(255),                      -- A1
    CustomerCategory varchar(100),                      -- A1
    CountryName      varchar(100),                      -- A1
    City             varchar(255),                      -- A1
    StateName        varchar(255),                      -- A1
    ZipCode          varchar(50),                       -- A1
    VatNumber        varchar(50),                       -- A1
    ParentCustomerName varchar(255),                    -- A1
    IsActive         boolean,                           -- A1
    CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerSK)
);

CREATE UNIQUE INDEX IF NOT EXISTS UK_DimCustomer_CustomerID 
    ON MART.DimCustomer (CustomerID);

CREATE INDEX IF NOT EXISTS IX_DimCustomer_CustomerName 
    ON MART.DimCustomer (CustomerName);

INSERT INTO MART.DimCustomer (
    CustomerID, CustomerName, IsCompany, IndustryName, CustomerCategory, 
    CountryName, City, StateName, ZipCode, VatNumber, ParentCustomerName, IsActive
)
SELECT 
    p.id, 
    p.name, 
    p.is_company, 
    i.name, 
    CASE 
        WHEN p.customer_rank >= 3 THEN 'Premium'
        WHEN p.customer_rank >= 2 THEN 'Standard'
        WHEN p.customer_rank >= 1 THEN 'Basic'
        ELSE 'Unranked'
    END,
    c.name, 
    p.city, 
    s.name, 
    p.zip, 
    p.vat, 
    par.name, 
    p.active
FROM public.res_partner p
LEFT JOIN public.res_partner_industry i ON p.industry_id = i.id
LEFT JOIN public.res_country c ON p.country_id = c.id
LEFT JOIN public.res_country_state s ON p.state_id = s.id
LEFT JOIN public.res_partner par ON p.parent_id = par.id
WHERE p.customer_rank > 0 AND p.active = true
ON CONFLICT (CustomerID) DO UPDATE SET
    CustomerName = EXCLUDED.CustomerName,
    IsCompany = EXCLUDED.IsCompany,
    IndustryName = EXCLUDED.IndustryName,
    CustomerCategory = EXCLUDED.CustomerCategory,
    CountryName = EXCLUDED.CountryName,
    City = EXCLUDED.City,
    StateName = EXCLUDED.StateName,
    ZipCode = EXCLUDED.ZipCode,
    VatNumber = EXCLUDED.VatNumber,
    ParentCustomerName = EXCLUDED.ParentCustomerName,
    IsActive = EXCLUDED.IsActive;