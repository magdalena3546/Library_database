-- search duplicates in Books Table
SELECT Title, Count(*) as NumberOfDuplicates 
FROM Books
GROUP BY Title
HAVING Count(*) > 1;

-- delete duplicates from Books Table
DELETE b1 FROM Books b1
INNER JOIN Books b2
WHERE b1.Title = b2.Title AND 
b1.bookID > b2.bookID;

-- insert data when reader is borrowing book
INSERT INTO Borrowings (BookID, UserID, BorrowDate)
VALUES (1, 3, '2024-01-15');
        
-- check if reader can borrow this book 
DELIMITER //
CREATE TRIGGER check_availability
BEFORE INSERT ON Borrowings
FOR EACH ROW
	BEGIN
		DECLARE existing_borrowings INT;
		SELECT COUNT(*) INTO existing_borrowings
		FROM Borrowings
		WHERE BookID = NEW.BookID AND ReturnDate IS NULL;
		IF existing_borrowings > 0 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Książka jest już wypożyczona.';
		END IF;
	END
//
DELIMITER ;

-- update returndate in borrowings, when reader gives back book
UPDATE 	Borrowings 
SET ReturnDate = DATE(NOW())
WHERE userID=3 AND bookID=2;

-- add delay and penalty 
DELIMITER // 
CREATE TRIGGER add_delay_and_penalty
BEFORE UPDATE ON Borrowings
	FOR EACH ROW
		BEGIN 
            IF DATEDIFF(NEW.ReturnDate, NEW.ExpectedReturnDate) > 0 THEN
				SET NEW.Delay = DATEDIFF(NEW.ReturnDate, NEW.ExpectedReturnDate);
				INSERT INTO Penalties(BorrowingID, Amount)
                VALUES (NEW.BorrowingID, NEW.Delay * 0.2);
            END IF;
        END
//
DELIMITER ;

-- change penalty to settled
UPDATE Penalties 
SET SETTLED = TRUE
WHERE BorrowingID = 2;



