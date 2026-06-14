-- 1. Create Clean Table
SELECT 
    ID,
    LTRIM(RTRIM(Project_Code)) AS [Project_Code],
    LTRIM(RTRIM(PQ)) AS [Process Reference],
    LTRIM(RTRIM(PO_SO)) AS [Order Name],
    LTRIM(RTRIM(ASN_DN)) AS [Reference],
    LTRIM(RTRIM(Country)) AS [Destination Country],
    LTRIM(RTRIM(Managed_By)) AS [Procurement Office],
    LTRIM(RTRIM(Fulfill_Via)) AS [Delivery Method],
    UPPER(LTRIM(RTRIM(Vendor_INCO_Term))) AS [Vendor INCO Term],
    LTRIM(RTRIM(Shipment_Mode)) AS [Mode of Transport],

    -- 🔹 Safe Date Conversion (No SET DATEFORMAT, explicit placeholder handling)
    TRY_CAST(CASE 
        WHEN LTRIM(RTRIM(PQ_First_Sent_to_Client_Date)) IN ('', 'Date Not Captured', 'Pre-PQ Process', 'N/A') THEN NULL 
        ELSE LTRIM(RTRIM(PQ_First_Sent_to_Client_Date)) 
    END AS DATE) AS [Order Date],
    TRY_CAST(CASE 
        WHEN LTRIM(RTRIM(PO_Sent_to_Vendor_Date)) IN ('', 'N/A - From RDC', 'Pre-PQ Process', 'N/A') THEN NULL 
        ELSE LTRIM(RTRIM(PO_Sent_to_Vendor_Date)) 
    END AS DATE) AS [Ship Date],
    TRY_CAST(CASE 
        WHEN LTRIM(RTRIM(Delivered_to_Client_Date)) IN ('', 'Pre-PQ Process', 'N/A') THEN NULL 
        ELSE LTRIM(RTRIM(Delivered_to_Client_Date)) 
    END AS DATE) AS [Arrival Date],

    LTRIM(RTRIM(Product_Group)) AS [Commodity Category],
    LTRIM(RTRIM(Sub_Classification)) AS [Product Classification],
    LTRIM(RTRIM(Vendor)) AS [Supplier],
    LTRIM(RTRIM(Item_Description)) AS [Product Full Description],
    LTRIM(RTRIM(Molecule_Test_Type)) AS [Product Short Description],
    LTRIM(RTRIM(Brand)) AS [Brand Name],
    LTRIM(RTRIM(Dosage)) AS [Dosage],
    LTRIM(RTRIM(Dosage_Form)) AS [Dosage Form],

    TRY_CAST(Line_Item_Quantity AS INT) AS [Quantity],
    TRY_CAST(REPLACE(LTRIM(RTRIM(Line_Item_Value)), ',', '') AS DECIMAL(18,2)) AS [Total Line Value],
    TRY_CAST(REPLACE(LTRIM(RTRIM(Unit_Price)), ',', '') AS DECIMAL(18,4)) AS [Unit Price],
    LTRIM(RTRIM(Manufacturing_Site)) AS [Manufacturer Location],

    CASE 
        WHEN UPPER(LTRIM(RTRIM(First_Line_Designation))) IN ('YES','Y','TRUE','1') THEN 'Yes'
        WHEN UPPER(LTRIM(RTRIM(First_Line_Designation))) IN ('NO','N','FALSE','0') THEN 'No'
        ELSE NULL END AS [WHO_Prequalified],

    LTRIM(RTRIM(Weight_Kilograms)) AS [Weight Notes],
    LTRIM(RTRIM(Freight_Cost_USD)) AS [Freight Notes],
    TRY_CAST(REPLACE(LTRIM(RTRIM(Line_Item_Insurance_USD)), ',', '') AS DECIMAL(18,4)) AS [Weight_Freight_Cost]
INTO SCMS_Delivery_Clean
FROM [dbo].[SCMS_Delivery_History_dataset];
GO

-- 2. Remove Duplicates (Keep row with latest Arrival Date)
WITH RankedData AS (
    SELECT *,
        ROW_NUMBER() OVER(PARTITION BY ID ORDER BY 
            CASE WHEN [Arrival Date] IS NULL THEN 1 ELSE 0 END,
            [Arrival Date] DESC) AS rn
    FROM SCMS_Delivery_Clean
)
DELETE FROM RankedData WHERE rn > 1;
GO

-- 3. Verification Query
SELECT 
    COUNT(*) AS TotalRows,
    COUNT([Order Date]) AS ValidOrderDates,
    COUNT([Ship Date]) AS ValidShipDates,
    COUNT([Arrival Date]) AS ValidArrivalDates,
    AVG([Unit Price]) AS AvgUnitPrice,
    SUM([Total Line Value]) AS TotalSpend
FROM SCMS_Delivery_Clean;

SELECT TOP 10 *
FROM SCMS_Delivery_Clean;