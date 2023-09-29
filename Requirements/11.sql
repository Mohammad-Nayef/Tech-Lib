--Stored Procedure - Borrowed Books Report:
--    - Procedure Name: sp_BorrowedBooksReport
--    - Purpose: Generate a report of books borrowed within a specified date range.
--    - Parameters: StartDate, EndDate
--    - Implementation: Retrieve all books borrowed within the given range, 
--			with details like borrower name and borrowing date.
--    - Return: Tabulated report of borrowed books.

DROP PROCEDURE IF EXISTS sp_BorrowedBooksReport

GO

CREATE PROCEDURE sp_BorrowedBooksReport (@StartDate DATE, @EndDate DATE)
AS BEGIN 
	SELECT books.book_id, title, author, date_borrowed, borrowers.borrower_id, 
		first_name, last_name FROM loans
	JOIN books ON loans.book_id = books.book_id
	JOIN borrowers ON loans.borrower_id = borrowers.borrower_id
	WHERE date_borrowed BETWEEN @StartDate AND @EndDate
	ORDER BY title
END

GO

--Example
EXEC sp_BorrowedBooksReport '1/1/2023', '9/25/2023'