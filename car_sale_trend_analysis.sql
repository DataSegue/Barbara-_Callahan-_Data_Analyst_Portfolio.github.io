/* ========================================
   Project: New & Used Car Price Trends
   Goal: Answer business questions about price trends,
         brand retention, and mileage impact for luxury vs. economy cars.
   ======================================== */

/* ----------------------------------------
1. Which car brands retain their value the best over time?
---------------------------------------- */
SELECT 
    c.make,
    EXTRACT(YEAR FROM CURRENT_DATE) - c.year AS car_age,
    ROUND(AVG(p.price_usd),2) AS avg_price
FROM car c
JOIN condition cond ON c.car_id = cond.car_id
JOIN price p ON c.car_id = p.car_id
GROUP BY c.make, car_age
ORDER BY c.make, car_age;


/* ----------------------------------------
2. How does mileage affect price differently 
   for luxury vs. economy cars?
---------------------------------------- */
SELECT 
    c.make,
    CASE 
        WHEN c.make IN ('BMW','Mercedes','Maserati','Mercedes-Benz','McLaren','Jaguar','Porsche','Lamborghini','Bentley','Ferrari', 'Rolls-Royce') THEN 'Luxury'
        ELSE 'Economy'
    END AS car_type,
    ROUND(AVG(p.price_usd),2) AS avg_price,
    ROUND(AVG(cond.mileage),0) AS avg_mileage
FROM car c
JOIN condition cond ON c.car_id = cond.car_id
JOIN price p ON c.car_id = p.car_id
GROUP BY c.make, car_type
ORDER BY car_type, avg_mileage;


/* ----------------------------------------
3a. Dealer-level pricing trends
---------------------------------------- */
SELECT 
    d.dealer_name,
    ROUND(AVG(p.price_usd),2) AS avg_price,
    COUNT(*) AS num_sales
FROM dealer d
JOIN price p ON d.car_id = p.car_id
GROUP BY d.dealer_name
ORDER BY avg_price DESC;


/* ----------------------------------------
3b. Yearly pricing trends (average price by year)
---------------------------------------- */
SELECT 
    c.year,
    ROUND(AVG(p.price_usd), 2) AS avg_price,
    COUNT(*) AS num_cars
FROM car c
JOIN price p ON c.car_id = p.car_id
GROUP BY c.year
ORDER BY c.year;


/* -------------------------------------
4a. Top-selling models 
---------------------------------------- */
SELECT 
    c.make, c.model, COUNT(*) AS total_sales
FROM car c
JOIN price p ON c.car_id = p.car_id
GROUP BY c.make, c.model
ORDER BY total_sales DESC
LIMIT 5;





/* ----------------------------------------
4b. Lowest-selling models 
---------------------------------------- */
SELECT 
    c.make, c.model, COUNT(*) AS total_sales
FROM car c
JOIN price p ON c.car_id = p.car_id
GROUP BY c.make, c.model
ORDER BY total_sales ASC
LIMIT 5;

/* ----------------------------------------
4C.  Dealer with the  highest  amount of units sold 
---------------------------------------- 
 

SELECT 
    d.dealer_name,
    COUNT(c.car_id) AS num_sales
FROM car c
JOIN dealer d ON c.car_id = d.car_id
JOIN price p ON c.car_id = p.car_id
GROUP BY d.dealer_name
ORDER BY num_sales DESC;










