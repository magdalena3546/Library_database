-- searching duplicates in Books Table
SELECT Title, Count(*) as NumberOfDuplicates 
FROM Books
GROUP BY Title
HAVING Count(*) > 1;

-- delete duplicates from Books Table
DELETE b1 FROM Books b1
INNER JOIN Books b2
WHERE b1.Title = b2.Title AND 
b1.bookID > b2.bookID;
