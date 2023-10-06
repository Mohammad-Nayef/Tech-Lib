--Database Function - Book Borrowing Frequency:
--    - Function Name: fn_BookBorrowingFrequency
--    - Purpose: Gauge the borrowing frequency of a book.
--    - Parameter: BookID
--    - Implementation: Count the number of times the book has been issued.
--    - Return: Borrowing count of the book.

CREATE OR ALTER FUNCTION fn_BookBorrowingFrequency (@BookID INT)
RETURNS INT AS 
BEGIN 
	RETURN (
		SELECT COUNT(*) FROM loans
		WHERE loans.book_id = @BookID
		GROUP BY loans.book_id
	)
END

GO 

--Example
SELECT dbo.fn_BookBorrowingFrequency (1099) AS [Book Borrowing Frequency]