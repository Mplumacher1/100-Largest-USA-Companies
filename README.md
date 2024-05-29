# Portfolio Project: Analysis of Top 100 Companies in the US
## Overview
- This portfolio project presents an analysis of the top 100 companies in the US, utilizing Python, SQL, Excel, and Tableau. The project follows a structured approach, starting with web scraping using Python to gather data, followed by data cleaning in Excel, visualization in Tableau, and concluding with answering analytical questions using SQL.
## Dashboard
<img width="923" alt="image" src="https://github.com/Mplumacher1/100-Largest-USA-Companies/assets/164207910/be26732e-dd6d-457c-a0eb-568345fc4ef5">

[Tableau link](https://public.tableau.com/app/profile/miguel.plumacher/viz/Top-USA-Companies/Dashboard1)

## Steps
### Step 1: Web Scraping with Python
- Utilized Python libraries such as BeautifulSoup, Pandas and requests to scrape data from [here](https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue)
<img width="861" alt="image" src="https://github.com/Mplumacher1/100-Largest-USA-Companies/assets/164207910/46c8a4fa-ee8e-4ff8-a119-0bf9addc9410">

- Extracted key information about the top 100 companies, including their names, industries, revenues, and other relevant metrics.
- Stored the scraped data in a structured format for further analysis.
```python
from bs4 import BeautifulSoup
import requests
import pandas as pd

# Define the URL of the Wikipedia page to scrape
url = 'https://en.wikipedia.org/wiki/List_of_largest_companies_in_the_United_States_by_revenue'

# Send a GET request to the URL and store the response in a variable
web_request = requests.get(url)

# Parse the HTML content of the webpage using BeautifulSoup
soup = BeautifulSoup(web_request.text, 'html')

# Find all tables in the HTML content and select the second table (index 1)
table = soup.find_all('table')[1]

# Find all table headers (th elements) in the selected table
head_titles = table.find_all('th')

# Extract the text from each table header and strip any extra whitespace
table_for_head_titles = [titles.text.strip() for titles in head_titles]

# Create a DataFrame with the extracted headers as column names
df = pd.DataFrame(columns = table_for_head_titles)
df

# Find all table rows (tr elements) in the selected table
column_data = table.find_all('tr')

# Loop through each row of the table, skipping the first row (headers)
for row in column_data[1:]:
     # Find all table data cells (td elements) in the current row
    row_data = row.find_all('td')

    # Extract the text from each cell and strip any extra whitespace
    individual_data = [data.text.strip() for data in row_data]

    # Get the current length of the DataFrame (number of rows)
    length = len(df)

    # Append the extracted row data to the DataFrame as a new row
    df.loc[length] = individual_data

# Display the DataFrame
df

# Save the DataFrame to a CSV file without the index column
df.to_csv(r'C:\Users\migue\OneDrive\Documents\Datasets\Largest_Companies.csv', index = False)
```
### Step 2: Data Cleaning with Excel
- Imported the scraped data into Excel for thorough cleaning and preparation.
- Removed the 'headquarters' column and used =textsplit to organize it into city and state
### Step 3: Visualization with Tableau
- Imported the cleaned dataset into Tableau for visualization and analysis.
- Created interactive dashboards and visualizations to showcase key insights about the top 100 companies.
- Utilized various chart types and features in Tableau to effectively communicate trends, patterns, and comparisons.
### Step 4: Analytical Queries with SQL
- Imported the finalized dataset into a SQL database for further analysis.
- Formulated SQL queries to answer specific analytical questions about the top 100 companies.
- Leveraged SQL functions and aggregations to extract meaningful insights from the dataset.
- Presented the findings in a clear and concise manner, supporting them with relevant visualizations or summaries.

Top 10 Companies by Revenue
```sql
SELECT company_name, revenue_USD_millions
FROM top_companies
ORDER BY revenue_USD_millions DESC
LIMIT 10;
```
company_name | revenue_USD_millions |
-------- | ---------|
Walmart	|611289|
Amazon	|513983|
ExxonMobil	|413680|
Apple	|394328|
UnitedHealth Group|	324162|
CVS Health|	322467|
Berkshire| Hathaway	|302089|
Alphabet	|282836|
McKesson Corporation|	276711|
Chevron Corporation|	246252|


Average Revenue
``` sql
SELECT ROUND(AVG(revenue_USD_millions),2) AS avg_revenue
FROM top_companies;
```
|avg_revenue|
---------|
|118086.97|

Top 10 Companies with the highest Revenue Growth
```sql
SELECT company_name, revenue_growth
FROM top_companies
ORDER BY revenue_growth DESC
LIMIT 10;
```

| company_name| revenue_growth|
--------------| --------------|
TD Synnex	|0.97|
World Fuel Services|	0.88|
United Airlines	|0.83|
PBF Energy	|0.72|
ConocoPhillips	|0.7|
Delta Air Lines	|0.69|
American Airlines|	0.64|
Performance Food Group|	0.62|
Valero Energy	|0.58|
Phillips 66	|0.53|


Average Revenue Growth
```sql
SELECT ROUND(AVG(revenue_growth),3) AS avg_revenue_growth
FROM top_companies;
```

|avg_revenue_growth|
--------------------|
|0.193|

Number of Companies by State
```sql
SELECT state, COUNT(*) AS company_count
FROM top_companies
GROUP BY state
ORDER BY company_count DESC;
```

|state | company_count |
--------| --------------|
 New York	| 14 |
 Texas	|13|
 California|	10|
 Illinois|	7|
 Ohio|	6|
 Minnesota|	4|
 New Jersey|	4|
 Virginia|	4|
 Massachusetts|	4|
 Washington	|3|
 Michigan	|3|
 Georgia	|3|
 Florida	|3|
 Arkansas|	2|
 Pennsylvania	|2|
 Connecticut|	2|
 D.C.|	2|
 North Carolina|	2|
 Tennessee	|2|
 Rhode Island	|1|
 Nebraska	|1|
 Indiana	|1|
 Missouri|	1|
 Kentucky	|1|
 Idaho	|1|
 Maryland|	1|
 Cook County	|1|
 Oregon|	1|
 
Top 5 States by Total Revenue
```sql
SELECT state, SUM(revenue_USD_millions) AS total_revenue
FROM top_companies
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 5;
```

|state | total_revenue|
-------|--------------|
 Texas	|1746953|
 California	|1427400|
 New York|	1128867|
 Washington	|939207|
 Ohio|	690882|

 
Top 5 Industries by Average Revenue
```sql
SELECT industry, ROUND(AVG(revenue_USD_millions),2) AS avg_revenue
FROM top_companies
GROUP BY industry
ORDER BY avg_revenue DESC
LIMIT 5;
```
industry| avg_revenue|
--------|------------|
Electronics industry	|394328.00|
Health	|276711.00|
Healthcare|	198228.00|
Pharmacy wholesale	|238587.00|
Retail and cloud computing|	513983.00|

Top 10 Companies by NUmber of Employees
```sql
SELECT company_name, number_of_employees
FROM top_companies
ORDER BY number_of_employees DESC
LIMIT 10;
```

company_name| number_of_employees|
------------|--------------------|
Walmart	|2100000|
Amazon	|1540000|
United States Postal Service|	576000|
FedEx	|518249|
The Home Depot|	471600|
Target Corporation	|440000|
Kroger	|430000|
United Parcel Service|	404700|
UnitedHealth Group|	400000|
Berkshire Hathaway	|383000|

Average Number of Employees
```sql
SELECT ROUND(AVG(number_of_employees),2) AS avg_num_employees
FROM top_companies;
```
|avg_num_employees|
------------------|
|169724.26|

Total Revenue by Industry and City
```sql
SELECT industry, city, SUM(revenue_USD_millions) AS total_revenue
FROM top_companies
GROUP BY industry, city
ORDER BY total_revenue DESC
LIMIT 10;
```

industry|city|total_revenue
--------|------|----------|
Retail	|Bentonville	|611289|
Retail and cloud computing|	Seattle	|513983|
Petroleum industry|	Spring	|413680|
Electronics industry|	Cupertino|	394328|
Petroleum industry	|Houston	|373386|
Healthcare	|Minnetonka|	324162|
Healthcare|	Woonsocket	|322467|
Financials|	New York City	|305623|
Conglomerate	|Omaha|	302089|
Technology and cloud computing|	Mountain View|	282836|


## Conclusion
- This portfolio project demonstrates a comprehensive approach to analyzing the top 100 companies in the US, combining web scraping, data cleaning, visualization, and analytical querying techniques. The structured format ensures reproducibility and clarity, allowing stakeholders to gain valuable insights into the performance and characteristics of these companies.
