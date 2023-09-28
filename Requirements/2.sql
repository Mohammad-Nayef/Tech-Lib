--Active Borrowers with CTEs: 
--Identify borrowers who've borrowed 2 or more books but haven't returned any using CTEs.

WITH active_loans AS (
	SELECT COUNT(*) AS [Current borrows], first_name, last_name 
	FROM borrowers
	JOIN loans ON borrowers.borrower_id = loans.borrower_id
	WHERE date_returned IS NULL
	GROUP BY first_name, last_name
)

SELECT * FROM active_loans
WHERE [Current borrows] > 1
ORDER BY [Current borrows]