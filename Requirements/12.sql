--Trigger Implementation
--	Design a trigger to log an entry into a separate AuditLog table whenever 
--	a book's status changes from 'Available' to 'Borrowed' or vice versa. 
--	The AuditLog should capture BookID, StatusChange, and ChangeDate.

CREATE TABLE BookStatusAuditLog (
	book_id INT,
	status_change VARCHAR(30),
	change_date DATE
)

GO

DROP TRIGGER IF EXISTS BookStatusChangeTrigger

GO

CREATE TRIGGER BookStatusChangeTrigger
ON books
AFTER UPDATE
AS IF (UPDATE (current_status))
BEGIN
	INSERT INTO BookStatusAuditLog
	SELECT INSERTED.book_id, 
		CONCAT('From ', DELETED.current_status, ' to ', INSERTED.current_status), 
		GETDATE()
	FROM DELETED
	JOIN INSERTED ON DELETED.book_id = INSERTED.book_id
	--VALUES (@book_id, CONCAT('From ', @status_before, 'to ', @status_after), GETDATE())
END

GO

--Example
UPDATE books
SET current_status = 'Available'
WHERE book_id = 2049

SELECT * FROM BookStatusAuditLog