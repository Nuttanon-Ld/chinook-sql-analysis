# 🎧 Chinook SQL Data Analysis

This project uses the Chinook sample database to explore music sales data using SQL queries.

## 📊 Topics Covered
- Top revenue-generating customers
- Songs with the longest duration
- Most expensive tracks
- Number of tracks per genre and album
- Average song length per artist
- Tracks appearing in multiple playlists
- Categorizing songs by price

## 🛠 Tools Used
- SQLite / PostgreSQL
- DB Browser for SQLite (or your preferred tool)

## 📁 File Included
- `Chinook_test.sql` – All queries grouped by topic

## 📌 Sample Query Output
```sql
SELECT FirstName || ' ' || LastName AS Customer_Name, 
       SUM(i.Total) AS Total_Spend
FROM customers c
JOIN invoices i ON c.CustomerId = i.CustomerId 
GROUP BY Customer_Name
ORDER BY Total_Spend DESC
LIMIT 3;
