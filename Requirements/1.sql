--List of Borrowed Books: 
--Retrieve all books borrowed by a specific borrower, including those currently unreturned.

SELECT books.book_id, books.title, books.author, borrowers.borrower_id, borrowers.first_name AS [borrower first name],
borrowers.last_name AS [borrower last name], date_borrowed
FROM loans
JOIN books ON loans.book_id = books.book_id
JOIN borrowers ON loans.borrower_id = borrowers.borrower_id
ORDER BY date_borrowed