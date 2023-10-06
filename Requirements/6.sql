--Database Function - Calculate Overdue Fees:
--    - Function Name: fn_CalculateOverdueFees
--    - Purpose: Compute overdue fees for a given loan.
--    - Parameter: LoanID
--    - Implementation: Charge fees based on overdue days: $1/day for up to 30 days, $2/day after.
--    - Return: Overdue fee for the LoanID.

CREATE OR ALTER FUNCTION fn_CalculateOverdueDays (@loanID INT)
RETURNS INT AS
BEGIN
	RETURN (
		SELECT DATEDIFF(DAY, due_date, GETDATE()) FROM loans
		WHERE loan_id = @loanID
	)
END

GO

CREATE OR ALTER FUNCTION fn_CalculateOverdueFees (@loanID INT)
RETURNS INT AS
BEGIN
	DECLARE @overdue_fees INT
	SET @overdue_fees = dbo.fn_CalculateOverdueDays(@loanID)
	IF (@overdue_fees > 30) 
		SET @overdue_fees = 2 * @overdue_fees - 30

	IF (@overdue_fees < 0)
		RETURN 0
	RETURN @overdue_fees
END

GO

--Example with a loan with due_date = 2023-08-16
SELECT dbo.fn_CalculateOverdueFees (107) AS [Overdue fees]
