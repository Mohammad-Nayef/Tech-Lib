--Overdue Analysis: 
--	List all books overdue by more than 30 days with their associated borrowers.

SELECT * FROM loans
JOIN books ON loans.book_id = books.book_id
JOIN borrowers ON loans.borrower_id = borrowers.borrower_id
WHERE due_date < date_returned AND DATEDIFF(DAY, due_date, date_returned) > 30
	OR
	DATEDIFF(DAY, due_date, GETDATE()) > 30 AND date_returned IS NULL
