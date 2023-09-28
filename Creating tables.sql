CREATE TABLE books (
	book_id INT IDENTITY(1078 ,1) PRIMARY KEY,
	title VARCHAR(324),
	author VARCHAR(456),
	isbn VARCHAR(13),
	published_date DATE,
	genre VARCHAR(50),
	shelf_location INT,
	current_status VARCHAR(10)
)

GO

CREATE TABLE borrowers (
	borrower_id INT IDENTITY(2142 ,1) PRIMARY KEY,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	email VARCHAR(320),
	date_of_birth DATE,
	membership_date DATE
)

GO

CREATE TABLE loans (
	loan_id INT IDENTITY(1, 1) PRIMARY KEY,
	book_id INT NOT NULL FOREIGN KEY REFERENCES books(book_id),
	borrower_id INT NOT NULL FOREIGN KEY REFERENCES borrowers(borrower_id),
	date_borrowed DATE,
	due_date DATE,
	date_returned DATE
)