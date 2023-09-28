--Weekly peak days: 
--The library is planning to employ a new part-time worker. 
--This worker will work 3 days weekly in the library. 
--From the data you have, determine the most 3 days in the week 
--that have the most share of the loans and display the result 
--of each day as a percentage of all loans. Sort the results 
--from the highest percentage to the lowest percentage. 
--(eg. 25.18% of the loans happen on Monday...)

DECLARE @loans_count FLOAT
SET @loans_count = (SELECT COUNT(*) FROM loans)

SELECT TOP 3 
(COUNT(FORMAT(date_borrowed, 'dddd')) / @loans_count) * 100 AS [Loans percentage], 
FORMAT(date_borrowed, 'dddd') AS 'Weekday'
FROM loans
GROUP BY FORMAT(date_borrowed, 'dddd') 
ORDER BY[Loans percentage] DESC