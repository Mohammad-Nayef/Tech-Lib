--Author Popularity using Aggregation: 
--	Rank authors by the borrowing frequency of their books.

WITH borrowings AS (
	SELECT COUNT(*) as [Number of borrowings], author
	FROM books
	JOIN loans ON books.book_id = loans.book_id
	GROUP BY author
)

SELECT DENSE_RANK() OVER(ORDER BY [Number of borrowings] DESC) AS [Author rank],
	[Number of borrowings], author
FROM borrowings
ORDER BY [Author rank] ASC