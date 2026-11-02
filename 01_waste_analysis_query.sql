-- 1. Create a New Database
CREATE DATABASE FB_CostControl;
USE FB_CostControl;

-- 2. Create the Raw Inventory & Waste Table (Tab 1 Data Source)
CREATE TABLE menu_raw_inventory (
    item_id VARCHAR(10) PRIMARY KEY,
    menu_item VARCHAR(100) NOT NULL,
    qty_prepared INT NOT NULL,
    qty_waste INT NOT NULL,
    unit_cost DECIMAL(10, 2) NOT NULL
);

-- 3. Insert Raw Historical Data (Sample of top menu items)
INSERT INTO menu_raw_inventory (item_id, menu_item, qty_prepared, qty_waste, unit_cost) VALUES
('B001', 'Royal Saffron Rice', 250, 35, 2.50),
('B002', 'Authentic Beef Rendang', 300, 42, 3.50),
('B003', 'Honey Spiced Tomato Chicken', 280, 50, 3.15),
('B004', 'Traditional Spiced Fried Chicken', 250, 22, 2.25),
('B005', 'Beef Rendang Tok', 180, 15, 4.20);

-- 4. Calculate Net Sales Volume, Revenue, and Food Cost Metrics
SELECT 
    item_id,
    menu_item,
    -- Simulating the optimized selling price strategy
    CASE 
        WHEN item_id = 'B001' THEN 8.33
        WHEN item_id = 'B002' THEN 10.67
        WHEN item_id = 'B003' THEN 9.85
        WHEN item_id = 'B004' THEN 8.25
        WHEN item_id = 'B005' THEN 15.00
        ELSE 10.00
    END AS unit_selling_price,
    (qty_prepared - qty_waste) AS qty_sold,
    (qty_prepared * unit_cost) AS total_cost_prepared,
    (qty_waste * unit_cost) AS waste_cost_myr,
    ((qty_prepared - qty_waste) * unit_cost) AS consumed_food_cost_myr,
    ROUND(((qty_prepared - qty_waste) * 
        CASE 
            WHEN item_id = 'B001' THEN 8.33
            WHEN item_id = 'B002' THEN 10.67
            WHEN item_id = 'B003' THEN 9.85
            WHEN item_id = 'B004' THEN 8.25
            WHEN item_id = 'B005' THEN 15.00
            ELSE 10.00
        END), 2) AS total_revenue_potential
FROM menu_raw_inventory;

-- 5. Automate Matrix Quadrants (Popularity >= 200 portions, Food Cost <= 35%)
WITH menu_metrics AS (
    SELECT 
        item_id,
        menu_item,
        (qty_prepared - qty_waste) AS qty_sold,
        ((qty_prepared - qty_waste) * unit_cost) AS consumed_food_cost,
        ROUND(((qty_prepared - qty_waste) * 
            CASE 
                WHEN item_id = 'B001' THEN 8.33
                WHEN item_id = 'B002' THEN 10.67
                WHEN item_id = 'B003' THEN 9.85
                WHEN item_id = 'B004' THEN 8.25
                WHEN item_id = 'B005' THEN 15.00
                ELSE 10.00
            END), 2) AS total_revenue
    FROM menu_raw_inventory
),
menu_percentages AS (
    SELECT 
        item_id,
        menu_item,
        qty_sold,
        ROUND((consumed_food_cost / total_revenue) * 100, 2) AS food_cost_percentage
    FROM menu_metrics
)
SELECT 
    item_id,
    menu_item,
    qty_sold,
    food_cost_percentage,
    CASE 
        WHEN qty_sold >= 200 AND food_cost_percentage <= 35.00 THEN 'STAR'
        WHEN qty_sold >= 200 AND food_cost_percentage > 35.00 THEN 'PLOWHORSE'
        WHEN qty_sold < 200 AND food_cost_percentage <= 35.00 THEN 'PUZZLE'
        ELSE 'DOG'
    END AS menu_classification,
    CASE 
        WHEN qty_sold >= 200 AND food_cost_percentage <= 35.00 THEN 'Maintain'
        WHEN qty_sold >= 200 AND food_cost_percentage > 35.00 THEN 'Review Pricing / Reduce Portion'
        WHEN qty_sold < 200 AND food_cost_percentage <= 35.00 THEN 'Reduce Waste'
        ELSE 'Remove Item'
    END AS management_strategy
FROM menu_percentages;
