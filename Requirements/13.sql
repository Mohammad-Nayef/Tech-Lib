--SQL Stored Procedure with Temp Table:
--	Design a stored procedure that retrieves all borrowers who have overdue books. 
--	Store these borrowers in a temporary table, then join this temp table with 
--		the Loans table to list out the specific overdue books for each borrower.

DROP TABLE IF EXISTS #borrowers_with_overdue_books

GO

CREATE TABLE #borrowers_with_overdue_books (
	borrower_id INT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	email VARCHAR(320),
)

GO

CREATE OR ALTER PROCEDURE sp_OverdueBorrowings
AS BEGIN
	INSERT INTO #borrowers_with_overdue_books
	SELECT borrowers.borrower_id, first_name, last_name, email
	FROM loans
	JOIN borrowers ON borrowers.borrower_id = loans.borrower_id
	WHERE due_date < GETDATE() AND date_returned IS NULL
END

GO

EXEC sp_OverdueBorrowings

GO

SELECT DISTINCT * FROM #borrowers_with_overdue_books
JOIN loans ON #borrowers_with_overdue_books.borrower_id = loans.borrower_id
JOIN books ON loans.book_id = books.book_id
WHERE due_date < GETDATE() AND date_returned IS NULL