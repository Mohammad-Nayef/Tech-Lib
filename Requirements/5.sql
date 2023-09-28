--Stored Procedure - Add New Borrowers:
--	Procedure Name: sp_AddNewBorrower
--	Purpose: Streamline the process of adding a new borrower.
--	Parameters: FirstName, LastName, Email, DateOfBirth, MembershipDate.
--	Implementation: Check if an email exists; if not, add to Borrowers. 
--				  If existing, return an error message.
--	Return: The new BorrowerID or an error message.

DROP PROCEDURE IF EXISTS sp_AddNewBorrower;

GO 

CREATE PROCEDURE sp_AddNewBorrower (@first_name VARCHAR(20), @last_name VARCHAR(20),
	@email VARCHAR(320), @date_of_birth DATE, @membership_date DATE)
AS BEGIN 
	IF (@email IN (SELECT email FROM borrowers))
		SELECT 'The email already exists' AS [Error message]
	ELSE 
		BEGIN
			INSERT INTO borrowers (first_name, last_name, email, date_of_birth,	membership_date)
			VALUES (@first_name, @last_name, @email, @date_of_birth, @membership_date)

			SELECT borrower_id AS [New borrower ID] FROM borrowers
			WHERE email = @email
		END
END

GO

--Example
EXEC sp_AddNewBorrower 'Mohammad', 'Nayef', 'cs.moh.nayef@gmail.com', '4-Nov-2003', '1-Jan-2023'