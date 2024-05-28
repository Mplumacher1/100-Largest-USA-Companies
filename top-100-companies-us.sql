CREATE TABLE IF NOT EXISTS top_companies(
	company_rank INT PRIMARY KEY,
    company_name TEXT,
    industry TEXT,
    revenue_USD_millions INT,
    revenue_growth FLOAT,
    number_of_employees INT,
    city TEXT,
    state TEXT
);

SELECT *
FROM top_companies;

-- Top 10 Companies by Revenue
SELECT company_name, revenue_USD_millions
FROM top_companies
ORDER BY revenue_USD_millions DESC
LIMIT 10;
-- Average Revenue:
SELECT ROUND(AVG(revenue_USD_millions),2) AS avg_revenue
FROM top_companies;
-- Top 10 Companies with the highest Revenue Growth
SELECT company_name, revenue_growth
FROM top_companies
ORDER BY revenue_growth DESC
LIMIT 10;
-- Average Revenue Growth
SELECT ROUND(AVG(revenue_growth),3) AS avg_revenue_growth
FROM top_companies;
-- Number of Companies by State
SELECT state, COUNT(*) AS company_count
FROM top_companies
GROUP BY state
ORDER BY company_count DESC;
-- Top 6 States by Total Revenue
SELECT state, SUM(revenue_USD_millions) AS total_revenue
FROM top_companies
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 5;
-- Top 5 Industries by Average Revenue
SELECT industry, ROUND(AVG(revenue_USD_millions),2) AS avg_revenue
FROM top_companies
GROUP BY industry
ORDER BY avg_revenue DESC
LIMIT 5;
-- Top 10 Companies by NUmber of Employees
SELECT company_name, number_of_employees
FROM top_companies
ORDER BY number_of_employees DESC
LIMIT 10;
-- Average Number of Employees
SELECT ROUND(AVG(number_of_employees),2) AS avg_num_employees
FROM top_companies;
-- Total Revenue by Industry and City
SELECT industry, city, SUM(revenue_USD_millions) AS total_revenue
FROM top_companies
GROUP BY industry, city
ORDER BY total_revenue DESC
LIMIT 10;

