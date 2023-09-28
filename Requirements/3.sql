--Borrowing Frequency using Window Functions: Rank borrowers based on borrowing frequency.

WITH borrowings AS (
	SELECT COUNT(*) as [Number of borrowings], first_name, last_name
	FROM loans
	JOIN borrowers ON borrowers.borrower_id = loans.borrower_id
	GROUP BY first_name, last_name
)

SELECT DENSE_RANK() OVER(ORDER BY [Number of borrowings] DESC) AS [Borrower rank],
	[Number of borrowings], first_name, last_name
FROM borrowings
ORDER BY [Borrower rank] ASC