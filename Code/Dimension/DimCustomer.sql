-- Work Item: ad-hoc
-- Task: ad-hoc spec generation
-- Spec: Specification/Dimension/DimCustomer.md
-- Version: 1
-- Generated: 2026-06-28T10:20:16.980014+00:00
-- Notes: Initial implementation of DimCustomer dimension table.

CREATE SCHEMA IF NOT EXISTS Dimension;

CREATE TABLE IF NOT EXISTS Dimension.DimCustomer (
    CustomerKey        int GENERATED ALWAYS AS IDENTITY,
    CustomerID         int NOT NULL,
    CustomerName       varchar(255),
    CustomerType       varchar(50),
    IsCompany          boolean,
    IndustryName       varchar(255),
    City               varchar(100),
    StateName          varchar(100),
    CountryName        varchar(100),
    VatNumber          varchar(50),
    CustomerRank       int,
    ParentCustomerName varchar(255),
    SalespersonID      int,
    IsActive           boolean,
    CONSTRAINT PK_DimCustomer PRIMARY KEY (CustomerKey),
    CONSTRAINT UK_DimCustomer_CustomerID UNIQUE (CustomerID)
);

INSERT INTO Dimension.DimCustomer (
    CustomerID, CustomerName, CustomerType, IsCompany, IndustryName, City, 
    StateName, CountryName, VatNumber, CustomerRank, ParentCustomerName, 
    SalespersonID, IsActive
)
SELECT 
    s.id, s.name, s.type, s.is_company, ind.name, s.city, 
    st.name, co.name, s.vat, s.customer_rank, p.name, 
    s.user_id, s.active
FROM public.res_partner s
LEFT JOIN public.res_partner p ON s.parent_id = p.id
LEFT JOIN public.res_partner_industry ind ON s.industry_id = ind.id
LEFT JOIN public.res_country_state st ON s.state_id = st.id
LEFT JOIN public.res_country co ON s.country_id = co.id
WHERE s.active = true 
  AND s.customer_rank > 0
ON CONFLICT (CustomerID) DO UPDATE SET
    CustomerName = EXCLUDED.CustomerName,
    CustomerType = EXCLUDED.CustomerType,
    IsCompany = EXCLUDED.IsCompany,
    IndustryName = EXCLUDED.IndustryName,
    City = EXCLUDED.City,
    StateName = EXCLUDED.StateName,
    CountryName = EXCLUDED.CountryName,
    VatNumber = EXCLUDED.VatNumber,
    CustomerRank = EXCLUDED.CustomerRank,
    ParentCustomerName = EXCLUDED.ParentCustomerName,
    SalespersonID = EXCLUDED.SalespersonID,
    IsActive = EXCLUDED.IsActive;