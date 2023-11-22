--Popular Genre Analysis using Joins and Window Functions: 
--Identify the most popular genre for a given month.

CREATE OR ALTER PROCEDURE sp_TopGenreByMonth (@month INT) 
AS BEGIN
	 SELECT TOP 1 FIRST_VALUE(genre) OVER(ORDER BY [Number of borrowings] DESC) AS [Top genre], [Number of borrowings]
	 FROM (
		SELECT COUNT(genre) AS [Number of borrowings], genre FROM loans
		JOIN books ON loans.book_id = books.book_id
		WHERE MONTH(date_borrowed) = @month
		GROUP BY genre
	) AS [Borrowings per genre]
END

GO

--Example
EXEC sp_TopGenreByMonth 12