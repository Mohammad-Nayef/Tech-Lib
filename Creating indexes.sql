CREATE INDEX borrowers_index
ON borrowers(borrower_id, first_name, last_name)

CREATE INDEX books_index
ON books(book_id, genre, current_status)

CREATE INDEX loans_index
ON loans(loan_id, book_id, borrower_id)