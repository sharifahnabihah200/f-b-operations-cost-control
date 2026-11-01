-- Strategic Cost Control Query
-- Objective: Extract and aggregate food waste costs to identify key financial leakages in Banquet operations.

SELECT 
    Menu_Item, 
    Category,
    SUM(Qty_Prepared) AS Total_Prepared_Portions,
    SUM(Qty_Wasted) AS Total_Wasted_Portions,
    ROUND(SUM(Qty_Wasted * Unit_Cost), 2) AS Total_Waste_Cost_MYR
FROM 
    Restaurant_Operations_DB
WHERE 
    Event_Type = 'Banquet' 
GROUP BY 
    Menu_Item, 
    Category
ORDER BY 
    Total_Waste_Cost_MYR DESC;
