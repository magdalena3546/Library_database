USE Library;
-- select title from books and full name from authors
SELECT 
	Title, 
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM Books b 
LEFT JOIN Authors a ON b.AuthorID = a.AuthorID;

-- select authors and title and group by author's full name
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Title
FROM Authors a 
LEFT JOIN Books b ON a.AuthorID = b.AuthorID
ORDER BY FullName;