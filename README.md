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
Average Revenue
``` sql
SELECT ROUND(AVG(revenue_USD_millions),2) AS avg_revenue
FROM top_companies;
```
Top 10 Companies with the highest Revenue Growth
```sql
SELECT company_name, revenue_growth
FROM top_companies
ORDER BY revenue_growth DESC
LIMIT 10;
```
Average Revenue Growth
```sql
SELECT ROUND(AVG(revenue_growth),3) AS avg_revenue_growth
FROM top_companies;
```
Number of Companies by State
```sql
SELECT state, COUNT(*) AS company_count
FROM top_companies
GROUP BY state
ORDER BY company_count DESC;
```
Top 6 States by Total Revenue
```sql
SELECT state, SUM(revenue_USD_millions) AS total_revenue
FROM top_companies
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 5;
```
Top 5 Industries by Average Revenue
```sql
SELECT industry, ROUND(AVG(revenue_USD_millions),2) AS avg_revenue
FROM top_companies
GROUP BY industry
ORDER BY avg_revenue DESC
LIMIT 5;
```
Top 10 Companies by NUmber of Employees
```sql
SELECT company_name, number_of_employees
FROM top_companies
ORDER BY number_of_employees DESC
LIMIT 10;
```
Average Number of Employees
```sql
SELECT ROUND(AVG(number_of_employees),2) AS avg_num_employees
FROM top_companies;
```
Total Revenue by Industry and City
```sql
SELECT industry, city, SUM(revenue_USD_millions) AS total_revenue
FROM top_companies
GROUP BY industry, city
ORDER BY total_revenue DESC
LIMIT 10;
```

## Conclusion
- This portfolio project demonstrates a comprehensive approach to analyzing the top 100 companies in the US, combining web scraping, data cleaning, visualization, and analytical querying techniques. The structured format ensures reproducibility and clarity, allowing stakeholders to gain valuable insights into the performance and characteristics of these companies.
