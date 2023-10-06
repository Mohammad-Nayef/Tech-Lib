--Genre Preference by Age using Group By and Having: 
--	Determine the preferred genre of different age groups of borrowers. 
--	(Groups are (0,10), (11,20), (21,30)…)

CREATE OR ALTER FUNCTION fn_BorrowerAge (@BorrowerID INT)
RETURNS INT AS
BEGIN 
	RETURN (
		SELECT DATEDIFF(YEAR, date_of_birth, GETDATE())
		FROM borrowers
		WHERE borrower_id = @BorrowerID
	) 
END

GO

CREATE OR ALTER FUNCTION fn_SelectByAgeRange (@min_range INT, @max_range INT)
RETURNS TABLE AS
RETURN 
	SELECT genre, COUNT(*) as [Number of borrowings for the genre]
	FROM (	
		SELECT dbo.fn_BorrowerAge(loans.borrower_id) AS Age, genre
		FROM loans
		JOIN books ON loans.book_id = books.book_id
	) AS genreWithAge
	WHERE Age BETWEEN @min_range AND @max_range
	GROUP BY genre
GO

DROP TABLE IF EXISTS #borrowings_by_age

GO

CREATE TABLE #borrowings_by_age (
	age_group VARCHAR(10),
	genre VARCHAR(50),
	number_of_borrowings INT
)

GO

DECLARE @age INT
SET @age = 0

WHILE (@age < 100)
BEGIN
	DECLARE @age_group VARCHAR(10)
	SET @age_group = CONCAT(@age, ' - ', @age + 10)

	DECLARE @genre VARCHAR(50)
	SET @genre = (
		SELECT TOP 1 genre
		FROM dbo.fn_SelectByAgeRange (@age, @age + 10)
		ORDER BY [Number of borrowings for the genre] DESC
	)

	DECLARE @number_of_borrowings INT
	SET @number_of_borrowings = (
		SELECT TOP 1 [Number of borrowings for the genre]
		FROM dbo.fn_SelectByAgeRange (@age, @age + 10)
		ORDER BY [Number of borrowings for the genre] DESC
	)

	INSERT INTO #borrowings_by_age
	VALUES(@age_group, @genre, @number_of_borrowings)

	SET @age = @age + 10
END

SELECT * FROM #borrowings_by_age