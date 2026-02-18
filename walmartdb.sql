SELECT * FROM walmart_clean; --now showing the table in sql





---- first I have to find out  most which payment method used
SELECT payment_method, COUNT(*)
FROM walmart_clean
GROUP BY
    payment_method;















---- I have to find out wich pament methond in  contributing most by money
SELECT payment_method, SUM(Total_revenue)
FROM walmart_clean
GROUP BY
    payment_method
ORDER BY SUM(Total_revenue);




--- I'm trying to find out How many store we have
SELECT COUNT(DISTINCT Branch) from walmart_clean;




---Find Each payment method find  number of transcation and number of quantity
SELECT payment_method , COUNT(*) as no_payment,SUM(quantity)
FROM walmart_clean
GROUP BY payment_method;



--Identify the highest-rated category in each branch,displaying the branch,category AVG Rating
SELECT * from walmart_clean;
SELECt Branch ,MAX(rating),category FROM walmart_clean GROUP BY `Branch`,category ORDER BY `Branch`;




-- finding avrage rating of each store 
SELECT Branch,AVG(rating) FROM walmart_clean GROUP BY `Branch` ORDER BY `Branch`;


--identify the busiest day for each branch based on the number of transactions

ALTER TABLE walmart_clean MODIFY date DATE;


SELECT
    Branch,
    DAYNAME (walmart_clean.date ) as day_name,
    COUNT(*) as no_transactions
   

FROM walmart_clean
GROUP BY Branch,DAYNAME(walmart_clean.date) ORDER BY COUNT(*)DESC; 

--calculate the total quantity of items sold per payment method. List payment_method and total_quantity.
SELECT * FROM walmart_clean;
SELECT payment_method, SUM(quantity) as Total_quantity FROM walmart_clean GROUP BY payment_method;



-- determine the average, minimum,and maximum rating of category for each city.
--list the city,average-rating,min_rating,and max_rating
SELECT * FROM walmart_clean;

SELECT
    `City`,category,
    AVG(rating) as Avarage_rating_by_city,
    MIN(rating) as Minimum_rating_by_city,
    MAX(rating) as maximum_rating_by_city
FROM walmart_clean
GROUP BY
        category,`City`
ORDER BY
    `City`,category;


--calculate the total profit for each category by considering total_profit as
--(unit_price * quantity * profit_margin).
--List category and total_profit,order from highest to lowest profit.

SELECT
    category,
    SUM(unit_price * quantity * profit_margin) as total_profit
FROM walmart_clean
GROUP BY category;


--determine the most common payment method method for each branch.Dispalay Branch and the preferred_pament_method.
SELECT * FROM walmart_clean;

SELECT Branch,
payment_method, 
COUNT(invoice_id) as total_TRANSACTION_Count,
RANK() OVER(PARTITION BY `Branch` ORDER BY COUNT(*) DESC) as C_Rank
 FROM walmart_clean GROUP BY `Branch`,payment_method;


--categorize salse into 3 group  MORNING,AFTERNOON,EVENING
--Find out which of the shift and number of invoices
ALTER TABLE walmart_clean MODIFY time TIME;
SELECT * FROM walmart_clean;

SELECT `Branch`,
    CASE
        WHEN HOUR(time) < 12 THEN 'Morning'
        WHEN HOUR(time) BETWEEN 12 and 17  THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_category,
    COUNT(*)
FROM walmart_clean
GROUP BY
    `Branch`,time_category;        



-- identify 5 branch with highest decrese ratio in
--revenue compare to last year (current year 2023 and last year 2022)

SELECT * FROM walmart_clean;




SELECT date, YEAR(date) AS sale_year FROM walmart_clean; --Extract year from date 

ALTER TABLE walmart_clean ADD sale_year INT; -- added new columnb name but values are null

UPDATE walmart_clean SET sale_year = YEAR(date); --- now fill The values properly used year

CREATE VIEW Revenue2022 as -- Here I created a view for reuse this later revenue for 2022
SELECT Branch,SUM(Total_revenue) as Revenue FROM walmart_clean WHERE sale_year = 2022 GROUP BY `Branch`;

CREATE VIEW Revenue2023 as -- Here I created a view for reuse this later revenue for 2023
SELECT Branch, SUM(Total_revenue) as Revenue
FROM walmart_clean
WHERE
    sale_year = 2023
GROUP BY
    `Branch`;

SELECT
  last_year_revenue.`Branch`,
  last_year_revenue.`Revenue`,
  `Current_year_revenue`.`Revenue`
 FROM --useing join Now I can vissualize lastyear and current year revenue with going to use for find decrease ratio
    revenue2022 as last_year_revenue
    JOIN revenue2023 as Current_year_revenue
    ON last_year_revenue.`Branch` = `Current_year_revenue`.`Branch`
    WHERE last_year_revenue.`Revenue`>`Current_year_revenue`.`Revenue`;--to find out if any branch recuse thair revenue
    






SELECT
    last_year_revenue.Branch,
    last_year_revenue.Revenue AS Revenue_2022,
    Current_year_revenue.Revenue AS Revenue_2023,
    ROUND(
        (
            last_year_revenue.Revenue - Current_year_revenue.Revenue
        ) / last_year_revenue.Revenue * 100,
        2
    ) AS Decrease_Ratio
FROM
    revenue2022 AS last_year_revenue
    JOIN revenue2023 AS Current_year_revenue ON last_year_revenue.Branch = Current_year_revenue.Branch
WHERE
    last_year_revenue.Revenue > Current_year_revenue.Revenue
ORDER BY Decrease_Ratio DESC;