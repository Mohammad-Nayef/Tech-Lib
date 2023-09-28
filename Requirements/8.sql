--Overdue Analysis: 
--	List all books overdue by more than 30 days with their associated borrowers.

SELECT * FROM loans
JOIN books ON loans.book_id = books.book_id
JOIN borrowers ON loans.borrower_id = borrowers.borrower_id
WHERE DATEDIFF(DAY, due_date, GETDATE()) > 30