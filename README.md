# SQL
## Problem Statement
New Wheels is a vehicle resale company and has launched an app with an end-to-end service from listing the vehicle to shipping to customers. However, their sales have been dipping over the past year and are also experiencing decline in new customers due to critical customer feedbacks and ratings. A quarterly report with key metrics needs to be generated from the data to assess the health of the business and make insightful decisions. 
## Objective
Create a data pipeline that organizes and maintain quarterly data that are dumped as flat files using a SQL database that makes it become easier to answer business questions for the quarter as well as for the future of the company. 
## Solution Approach
  - Create a new database in MySQL.
  - Use MySQL workbench to build ingestion layer, transactional layer, and consumption layer by loading tables, creating stored procedures, generating views, and creating user defined functions (New_Wheels_DB.sql).
  - Attempt the 10 business questions asked by the CEO using SQL queries (New_Wheels_DB.sql).
  - Once these questions have been answered by writing SQL queries, download the csv file for each question (see 'Output Data from SQL Queries' folder) and use them generate visuals in Python using matplotlib/seaborn libraries (New_Wheels_Notebook.ipynb)
  - Then create a Quarterly Business Report (New_Wheels_Quarterly_Report.pdf) in form of a presentation to the CEO. 
