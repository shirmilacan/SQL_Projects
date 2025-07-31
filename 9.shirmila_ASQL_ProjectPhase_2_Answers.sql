--=======================================================
--Author	 : Shirmila Hewapathirana
--Create date: 2025-06-08
--Description: Project Phase II
--=======================================================
-- Create the database
CREATE DATABASE db_LibraryManagement;
GO

-- Use the database
USE db_LibraryManagement;
GO

---------------------- Create Tables ----------------------------

-- Create tbl_publisher(1)
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(150) NOT NULL PRIMARY KEY,
    publisher_PublisherAddress VARCHAR(200) NOT NULL,
    publisher_PublisherPhone VARCHAR(50) NOT NULL
);
GO

-- Create tbl_book(2)
CREATE TABLE tbl_book (
    book_BookID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    book_Title VARCHAR(100) NOT NULL,
    book_PublisherName VARCHAR(150) NOT NULL,
	CONSTRAINT FK_TP_book_PublisherName FOREIGN KEY (book_PublisherName) REFERENCES tbl_publisher(publisher_PublisherName) ON DELETE CASCADE
);
GO

-- Create tbl_library_branch(3)
CREATE TABLE tbl_library_branch (
    library_branch_BranchID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    library_branch_BranchName VARCHAR(100) NOT NULL,
    library_branch_BranchAddress VARCHAR(200)
);
GO

-- Create tbl_borrower(4)
CREATE TABLE tbl_borrower (
    borrower_CardNo INT NOT NULL IDENTITY(100,1) PRIMARY KEY, --In data Card No starts from 100
    borrower_BorrowerName VARCHAR(150) NOT NULL,
    borrower_BorrowerAddress VARCHAR(200) NOT NULL,
    borrower_BorrowerPhone VARCHAR(50) NOT NULL
);
GO

-- Create tbl_book_loans(5)
CREATE TABLE tbl_book_loans (
    book_loans_LoansID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    book_loans_BookID INT NOT NULL,
    book_loans_BranchID INT NOT NULL,
    book_loans_CardNo INT NOT NULL,
    book_loans_DateOut DATE NOT NULL,
    book_loans_DueDate DATE NOT NULL,
	CONSTRAINT FK_TBk_book_loans_BookID FOREIGN KEY (book_loans_BookID) REFERENCES tbl_book(book_BookID) ON DELETE CASCADE,
	CONSTRAINT FK_TLB_book_loans_BranchID FOREIGN KEY (book_loans_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID) ON DELETE CASCADE,
	CONSTRAINT FK_TBo_book_loans_CardNo FOREIGN KEY (book_loans_CardNo) REFERENCES tbl_borrower(borrower_CardNo) ON DELETE CASCADE
);
GO

-- Create tbl_book_copies(6)
CREATE TABLE tbl_book_copies (
    book_copies_CopiesID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    book_copies_BookID INT NOT NULL,
    book_copies_BranchID INT NOT NULL,
    book_copies_No_Of_Copies INT NOT NULL,
	CONSTRAINT FK_TBk_book_copies_BookID FOREIGN KEY (book_copies_BookID) REFERENCES tbl_book(book_BookID) ON DELETE CASCADE,
	CONSTRAINT FK_TLB_book_copies_BranchID FOREIGN KEY (book_copies_BranchID) REFERENCES tbl_library_branch(library_branch_BranchID) ON DELETE CASCADE
);
GO

-- Create tbl_book_authors(7)
CREATE TABLE tbl_book_authors (
    book_authors_AuthorID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    book_authors_BookID INT NOT NULL,
    book_authors_AuthorName VARCHAR(255) NOT NULL,
	CONSTRAINT FK_TBk_book_authors_BookID FOREIGN KEY (book_authors_BookID) REFERENCES tbl_book(book_BookID) ON DELETE CASCADE
);
GO


/*=============================Input Data=======================*/

-- Insert into tbl_publisher
INSERT INTO tbl_publisher 
(publisher_PublisherName, publisher_PublisherAddress, publisher_PublisherPhone) 
VALUES
('DAW Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
('Viking','375 Hudson Street, New York, NY 10014','212-366-2000'),
('Signet Books','375 Hudson Street, New York, NY 10014','212-366-2000'),
('Chilton Books','Not Available','Not Available'),
('George Allen & Unwin','83 Alexander Ln, Crows Nest NSW 2065, Australia','+61-2-8425-0100'),
('Alfred A. Knopf','The Knopf Doubleday Group Domestic Rights, 1745 Broadway, New York, NY 10019','212-940-7390'),		
('Bloomsbury','Bloomsbury Publishing Inc., 1385 Broadway, 5th Floor, New York, NY 10018','212-419-5300'),
('Shinchosa','Oga Bldg. 8, 2-5-4 Sarugaku-cho, Chiyoda-ku, Tokyo 101-0064 Japan','+81-3-5577-6507'),
('Harper and Row','HarperCollins Publishers, 195 Broadway, New York, NY 10007','212-207-7000'),
('Pan Books','175 Fifth Avenue, New York, NY 10010','646-307-5745'),
('Chalto & Windus','375 Hudson Street, New York, NY 10014','212-366-2000'),
('Harcourt Brace Jovanovich','3 Park Ave, New York, NY 10016','212-420-5800'),
('W.W. Norton','W. W. Norton & Company, Inc., 500 Fifth Avenue, New York, New York 10110','212-354-5500'),
('Scholastic','557 Broadway, New York, NY 10012','800-724-6527'),
('Bantam','375 Hudson Street, New York, NY 10014','212-366-2000'),
('Picador USA','175 Fifth Avenue, New York, NY 10010','646-307-5745');		

SELECT * FROM tbl_publisher
GO

-- Insert into tbl_book
INSERT INTO tbl_book
	(book_Title, book_PublisherName)
	VALUES 
	('The Name of the Wind', 'DAW Books'),
	('It', 'Viking'),
	('The Green Mile', 'Signet Books'),
	('Dune', 'Chilton Books'),
	('The Hobbit', 'George Allen & Unwin'),
	('Eragon', 'Alfred A. Knopf'),
	('A Wise Mans Fear', 'DAW Books'),
	('Harry Potter and the Philosophers Stone', 'Bloomsbury'),
	('Hard Boiled Wonderland and The End of the World', 'Shinchosa'),
	('The Giving Tree', 'Harper and Row'),
	('The Hitchhikers Guide to the Galaxy', 'Pan Books'),
	('Brave New World', 'Chalto & Windus'),
	('The Princess Bride', 'Harcourt Brace Jovanovich'),
	('Fight Club', 'W.W. Norton'),
	('Holes', 'Scholastic'),
	('Harry Potter and the Chamber of Secrets', 'Bloomsbury'),
	('Harry Potter and the Prisoner of Azkaban', 'Bloomsbury'),
	('The Fellowship of the Ring', 'George Allen & Unwin'),
	('A Game of Thrones', 'Bantam'),
	('The Lost Tribe', 'Picador USA');

SELECT * FROM tbl_book
GO

-- Insert into tbl_library_branch
INSERT INTO tbl_library_branch
	(library_branch_BranchName, library_branch_BranchAddress)
	VALUES
	('Sharpstown','32 Corner Road, New York, NY 10012'),
	('Central','491 3rd Street, New York, NY 10014'),
	('Saline','40 State Street, Saline, MI 48176'),
	('Ann Arbor','101 South University, Ann Arbor, MI 48104');

SELECT * FROM tbl_library_branch
GO

-- Insert into tbl_borrower
INSERT INTO tbl_borrower
	(borrower_BorrowerName, borrower_BorrowerAddress, borrower_BorrowerPhone)
	VALUES
	('Joe Smith','1321 4th Street, New York, NY 10014','212-312-1234'),
	('Jane Smith','1321 4th Street, New York, NY 10014','212-931-4124'),
	('Tom Li','981 Main Street, Ann Arbor, MI 48104','734-902-7455'),
	('Angela Thompson','2212 Green Avenue, Ann Arbor, MI 48104','313-591-2122'),
	('Harry Emnace','121 Park Drive, Ann Arbor, MI 48104','412-512-5522'),
	('Tom Haverford','23 75th Street, New York, NY 10014','212-631-3418'),
	('Haley Jackson','231 52nd Avenue New York, NY 10014','212-419-9935'),
	('Michael Horford','653 Glen Avenue, Ann Arbor, MI 48104','734-998-1513');

select * from tbl_borrower
GO

-- Insert into tbl_book_loans
	(book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
	VALUES
	('1','1','100','1/1/18','2/2/18'),
	('2','1','100','1/1/18','2/2/18'),
	('3','1','100','1/1/18','2/2/18'),
	('4','1','100','1/1/18','2/2/18'),
	('5','1','102','1/3/18','2/3/18'),
	('6','1','102','1/3/18','2/3/18'),
	('7','1','102','1/3/18','2/3/18'),
	('8','1','102','1/3/18','2/3/18'),
	('9','1','102','1/3/18','2/3/18'),
	('11','1','102','1/3/18','2/3/18'),
	('12','2','105','12/12/17','1/12/18'),
	('10','2','105','12/12/17','1/12/17'),
	('20','2','105','2/3/18','3/3/18'),
	('18','2','105','1/5/18','2/5/18'),
	('19','2','105','1/5/18','2/5/18'),
	('19','2','100','1/3/18','2/3/18'),
	('11','2','106','1/7/18','2/7/18'),
	('1','2','106','1/7/18','2/7/18'),
	('2','2','100','1/7/18','2/7/18'),
	('3','2','100','1/7/18','2/7/18'),
	('5','2','105','12/12/17','1/12/18'),
	('4','3','103','1/9/18','2/9/18'),
	('7','3','102','1/3/18','2/3/18'),
	('17','3','102','1/3/18','2/3/18'),
	('16','3','104','1/3/18','2/3/18'),
	('15','3','104','1/3/18','2/3/18'),
	('15','3','107','1/3/18','2/3/18'),
	('14','3','104','1/3/18','2/3/18'),
	('13','3','107','1/3/18','2/3/18'),
	('13','3','102','1/3/18','2/3/18'),
	('19','3','102','12/12/17','1/12/18'),
	('20','4','103','1/3/18','2/3/18'),
	('1','4','102','1/12/18','2/12/18'),
	('3','4','107','1/3/18','2/3/18'),
	('18','4','107','1/3/18','2/3/18'),
	('12','4','102','1/4/18','2/4/18'),
	('11','4','103','1/15/18','2/15/18'),
	('9','4','103','1/15/18','2/15/18'),
	('7','4','107','1/1/18','2/2/18'),
	('4','4','103','1/1/18','2/2/18'),
	('1','4','103','2/2/17','3/2/18'),
	('20','4','103','1/3/18','2/3/18'),
	('1','4','102','1/12/18','2/12/18'),
	('3','4','107','1/13/18','2/13/18'),
	('18','4','107','1/13/18','2/13/18'),
	('12','4','102','1/14/18','2/14/18'),
	('11','4','103','1/15/18','2/15/18'),
	('9','4','103','1/15/18','2/15/18'),
	('7','4','107','1/19/18','2/19/18'),
	('4','4','103','1/19/18','2/19/18'),
	('1','4','103','1/22/18','2/22/18');

SELECT * FROM tbl_book_loans
GO

-- Insert into tbl_book_copies
INSERT INTO tbl_book_copies
	(book_copies_BookID, book_copies_BranchID, book_copies_No_Of_Copies)
	VALUES
	('1','1','5'),
	('2','1','5'),
	('3','1','5'),
	('4','1','5'),
	('5','1','5'),
	('6','1','5'),
	('7','1','5'),
	('8','1','5'),
	('9','1','5'),
	('10','1','5'),
	('11','1','5'),
	('12','1','5'),
	('13','1','5'),
	('14','1','5'),
	('15','1','5'),
	('16','1','5'),
	('17','1','5'),
	('18','1','5'),
	('19','1','5'),
	('20','1','5'),
	('1','2','5'),
	('2','2','5'),
	('3','2','5'),
	('4','2','5'),
	('5','2','5'),
	('6','2','5'),
	('7','2','5'),
	('8','2','5'),
	('9','2','5'),
	('10','2','5'),
	('11','2','5'),
	('12','2','5'),
	('13','2','5'),
	('14','2','5'),
	('15','2','5'),
	('16','2','5'),
	('17','2','5'),
	('18','2','5'),
	('19','2','5'),
	('20','2','5'),
	('1','3','5'),
	('2','3','5'),
	('3','3','5'),
	('4','3','5'),
	('5','3','5'),
	('6','3','5'),
	('7','3','5'),
	('8','3','5'),
	('9','3','5'),
	('10','3','5'),
	('11','3','5'),
	('12','3','5'),
	('13','3','5'),
	('14','3','5'),
	('15','3','5'),
	('16','3','5'),
	('17','3','5'),
	('18','3','5'),
	('19','3','5'),
	('20','3','5'),
	('1','4','5'),
	('2','4','5'),
	('3','4','5'),
	('4','4','5'),
	('5','4','5'),
	('6','4','5'),
	('7','4','5'),
	('8','4','5'),
	('9','4','5'),
	('10','4','5'),
	('11','4','5'),
	('12','4','5'),
	('13','4','5'),
	('14','4','5'),
	('15','4','5'),
	('16','4','5'),
	('17','4','5'),
	('18','4','5'),
	('19','4','5'),
	('20','4','5');

SELECT * FROM tbl_book_copies
GO

----insert into tbl_book_authors
INSERT INTO tbl_book_authors
	(book_authors_BookID,book_authors_AuthorName)
	VALUES
	('1','Patrick Rothfuss'),
	('2','Stephen King'),
	('3','Stephen King'),
	('4','Frank Herbert'),
	('5','J.R.R. Tolkien'),
	('6','Christopher Paolini'),
	('6','Patrick Rothfuss'),
	('8','J.K. Rowling'),
	('9','Haruki Murakami'),
	('10','Shel Silverstein'),
	('11','Douglas Adams'),
	('12','Aldous Huxley'),
	('13','William Goldman'),
	('14','Chuck Palahniuk'),
	('15','Louis Sachar'),
	('16','J.K. Rowling'),
	('17','J.K. Rowling'),
	('18','J.R.R. Tolkien'),
	('19','George R.R. Martin'),
	('20','Mark Lee');

SELECT * FROM tbl_book_authors
GO

-------------------- Create Queries to Answer Questions -----------------------------
--1. Find the titles of all books published by "Bloomsbury"
select book_title 
from tbl_book
where book_PublisherName = 'Bloomsbury'
go

-- 2. List the names of borrowers whose phone numbers start with the area code "212."
select borrower_BorrowerName
from tbl_borrower
where borrower_BorrowerPhone like '212%'
go

-- 3. Retrieve the titles of books with more than 10 copies available.
select * from tbl_book_copies
select * from tbl_book

select a.book_title--, sum(b.book_copies_No_Of_Copies) as totalBooks
from tbl_book a
join tbl_book_copies b
on a.book_BookID = b.book_copies_BookID
group by a.book_Title 
having sum(b.book_copies_No_Of_Copies) > 10
order by a.book_Title
go


-- 4. Display the names of borrowers who have borrowed books from the "Central" branch.
select * from tbl_library_branch
select * from tbl_book_loans
select * from tbl_borrower

select distinct c.borrower_BorrowerName --, a.library_branch_BranchID, a.library_branch_BranchName, b.book_loans_CardNo
from tbl_library_branch a
join tbl_book_loans b
on b.book_loans_branchID = a.library_branch_BranchID	
join tbl_borrower c
on c.borrower_CardNo = b.book_loans_CardNo
where a.library_branch_BranchName = 'Central'
go

-- 5. List the titles of books borrowed by borrower "Joe Smith."
select * from tbl_book_loans 
select * from tbl_book 
select * from tbl_borrower 

select distinct b.book_Title-- , a.book_loans_LoansID, c.borrower_BorrowerName
from tbl_book_loans a
join tbl_book b 
on a.book_loans_BookID = b.book_BookID
join tbl_borrower c 
on a.book_loans_CardNo = c.borrower_CardNo
where c.borrower_BorrowerName = 'Joe Smith';
go

-- 6. Find the names of publishers for the books authored by "J.K. Rowling."
select * from tbl_book
select * from tbl_book_authors

select distinct b.book_PublisherName--, a.book_authors_AuthorName
from tbl_book_authors a
join tbl_book b
on b.book_BookID = a.book_authors_BookID
where a.book_authors_AuthorName = 'J.K. Rowling'
go

-- 7. Count the total number of books available in the library.
select * from tbl_book_copies

select sum(book_copies_No_Of_Copies) as TotalBooksAvailable
from tbl_book_copies;
go

-- 8. Calculate the average number of copies available per book across all branches.
select avg(total_copies) as average_copies_per_book
from(
    select sum(c.book_copies_No_Of_Copies) as total_copies
    from tbl_book_copies c
    GROUP BY c.book_copies_BookID
) as book_totals;
go

-- 9. Find the branch with the highest number of books loaned out.
select 
	top 1 lb.library_branch_BranchName, 
	count(bl.book_loans_BookID) as total_loaned_books
from tbl_library_branch lb
join tbl_book_loans bl 
on lb.library_branch_BranchID = bl.book_loans_BranchID
group by lb.library_branch_BranchName
order by total_loaned_books desc;
go

-- 10. Insert a new book titled "The Catcher in the Rye" by "J.D. Salinger" into the database.
--question only provided book title and auther name. However to update books table I need to know the 
--publisher as wee. So I googled to get the publisher details and it is 
-- 'Little, Brown and Company' at '53 State St Ste 38, Boston, MA 02109' telephone : +1 617-227-0730

--check whether pbulihser is in databse
select * from tbl_publisher
where publisher_PublisherName like '%Little, Brown and Company%';

--not available, so update the tbl_publisher
insert into tbl_publisher
values ('Little, Brown and Company','53 State St Ste 38, Boston, MA 02109', '+1 617-227-0730' )
select * from tbl_publisher

--update tbl_book
insert into tbl_book
values ('The Catcher in the Rye', 'Little, Brown and Company')
select * from tbl_book

--update authers table
insert into tbl_book_authors
values('23','J.D. Salinger')
select * from tbl_book_authors
go
-- 11. Update the address of the "Sharpstown" library branch to "45 West Side Avenue, New York, NY 10012."
update tbl_library_branch
set library_branch_BranchAddress = '45 West Side Avenue, New York, NY 10012'
where library_branch_BranchName = 'Sharpstown';
go
select * from tbl_library_branch

-- 12. Remove all books published by "Pan Books" from the database.
delete from tbl_book
where book_PublisherName = 'Pan Books';
--note
--since i have included 'on delete cascade' allrelated entries will be automatically deleted 
--from tbl_book_loans, tbl_book_copies, tbl_book_authors

-- 13. Retrieve the names of borrowers who have borrowed the same book more than once.
select * from tbl_borrower
select * from tbl_book_loans

select b.borrower_BorrowerName
from tbl_borrower b
where b.borrower_CardNo in (
	select distinct a.book_loans_CardNo--, COUNT(a.book_loans_CardNo) as countA
	from tbl_book_loans a
	group by a.book_loans_CardNo, a.book_loans_BookID
	having count(a.book_loans_CardNo) > 1
	);
go

-- 14. Find the title of the book with the earliest due date.
select * from tbl_book_loans
select * from tbl_book

select b.book_Title
from tbl_book b
where b.book_BookID in (
	select top 1 book_loans_BookID
	from tbl_book_loans a
	order by a.book_loans_DueDate asc);
go

-- 15. List the names of borrowers who have borrowed books authored by both "Stephen King" and "J.K. Rowling."
select * from tbl_book_authors
select * from tbl_book_loans
select * from tbl_borrower

select br.borrower_BorrowerName
from tbl_borrower br
where br.borrower_CardNo in(
	select distinct b.book_loans_CardNo
	from tbl_book_loans b
	where b.book_loans_BookID in (
		select a.book_authors_BookID--, a.book_authors_AuthorName 
		from tbl_book_authors a
		where a.book_authors_AuthorName in 
		('Stephen King', 'J.K. Rowling')
		GROUP BY a.book_authors_BookID
		having COUNT(distinct a.book_authors_AuthorName)=2)
		);
go
-- 16. Find the names of borrowers who have borrowed books published by "Bloomsbury."
select * from tbl_borrower
select * from tbl_book_loans
select * from tbl_book

select distinct br.borrower_BorrowerName
from tbl_borrower br
join tbl_book_loans bl 
on br.borrower_CardNo = bl.book_loans_CardNo
join tbl_book b 
on bl.book_loans_BookID = b.book_BookID
where b.book_PublisherName = 'Bloomsbury';
go

-- 17. Retrieve the titles of books borrowed by borrowers located in New York.
select * from tbl_book
select * from tbl_book_loans
select * from tbl_borrower

select distinct b.book_Title
from tbl_book b
join tbl_book_loans bl 
on b.book_BookID = bl.book_loans_BookID
join tbl_borrower br 
on bl.book_loans_CardNo = br.borrower_CardNo
where br.borrower_BorrowerAddress LIKE '%New York%';
go

-- 18. Calculate the average number of books borrowed per borrower.
select * from tbl_book_loans

select avg(book_count) as AvgBooksPerBorrower
from (
    select book_loans_CardNo, count(book_loans_BookID) as book_count
    from tbl_book_loans
    group by book_loans_CardNo
) as borrower_books;
go

-- 19. Find the branch with the highest average number of books borrowed per borrower.
select * from tbl_book_loans
select * from tbl_library_branch

select 
	top 1 
	lb.library_branch_BranchName, 
	count(bl.book_loans_BookID) / count(distinct bl.book_loans_CardNo) as AvgBooksPerBorrower
from tbl_library_branch lb
join tbl_book_loans bl 
on lb.library_branch_BranchID = bl.book_loans_BranchID
group by lb.library_branch_BranchName
order by AvgBooksPerBorrower desc;
go

-- 20. Rank library branches based on the total number of books borrowed.
select * from tbl_library_branch
select * from tbl_book_loans

select lb.library_branch_BranchName, 
       count (bl.book_loans_BookID) as TotalBooksBorrowed,
       rank() over(order by count(bl.book_loans_BookID) desc) as BranchRank
from tbl_library_branch lb
join tbl_book_loans bl 
on lb.library_branch_BranchID = bl.book_loans_BranchID
group by lb.library_branch_BranchName
order by BranchRank;
go

-- 21. Calculate the percentage of books borrowed from each branch relative to total.
select * from tbl_book_loans
select * from tbl_library_branch

select lb.library_branch_BranchName, 
	   count(bl.book_loans_BookID) * 100 / 
	   (select count(book_loans_BookID) from tbl_book_loans) as BorrowedPercentage
from tbl_library_branch lb
join tbl_book_loans bl 
on lb.library_branch_BranchID = bl.book_loans_BranchID
group by lb.library_branch_BranchName
order by BorrowedPercentage desc;
go

-- 22. Find borrowers who borrowed books authored by "Stephen King" and "J.K. Rowling" from the same branch.
select * from tbl_borrower
select * from tbl_book_loans
select * from tbl_book_authors

select br.borrower_BorrowerName, bl.book_loans_BranchID
from tbl_borrower br
join tbl_book_loans bl 
on br.borrower_CardNo = bl.book_loans_CardNo
where bl.book_loans_BookID in (
    select book_authors_BookID
    from tbl_book_authors
    where book_authors_AuthorName in ('Stephen King', 'J.K. Rowling')
    group by book_authors_BookID
    having count (distinct book_authors_AuthorName) = 2
)
group by br.borrower_BorrowerName, bl.book_loans_BranchID;
go

-- 23. Borrowers who borrowed books from New York branches and have >5 books checked out.
select * from tbl_borrower
select * from tbl_book_loans
select * from tbl_library_branch

select	br.borrower_BorrowerName, 
		count(bl.book_loans_BookID) as BooksCheckedOut
from tbl_borrower br
join tbl_book_loans bl 
on br.borrower_CardNo = bl.book_loans_CardNo
join tbl_library_branch lb 
on bl.book_loans_BranchID = lb.library_branch_BranchID
where lb.library_branch_BranchAddress like '%New York%'
group by br.borrower_BorrowerName
having count(bl.book_loans_BookID) > 5
order by BooksCheckedOut desc;
go

-- 24. Copies of "The Lost Tribe" owned by "Sharpstown" branch.
select * from tbl_book
select * from tbl_library_branch
select * from tbl_book_copies

select sum(c.book_copies_No_Of_Copies) as TotalCopies
from tbl_book_copies c
join tbl_book b 
on c.book_copies_BookID = b.book_BookID
join tbl_library_branch lb 
on c.book_copies_BranchID = lb.library_branch_BranchID
where b.book_Title = 'The Lost Tribe'
and lb.library_branch_BranchName = 'Sharpstown';

-- 25. Copies of "The Lost Tribe" owned by each branch.
select * from tbl_book_copies
select * from tbl_book
select * from tbl_library_branch

select	lb.library_branch_BranchName, 
		count(bc.book_copies_CopiesID) as TotalCopies
from tbl_book_copies bc
join tbl_book b 
on bc.book_copies_BookID = b.book_BookID
join tbl_library_branch lb 
on bc.book_copies_BranchID = lb.library_branch_BranchID
where b.book_Title = 'The Lost Tribe'
group by lb.library_branch_BranchName
order by TotalCopies desc;
go

-- 26. Names of borrowers with no books checked out.
select * from tbl_borrower
select * from tbl_book_loans

select br.borrower_BorrowerName
from tbl_borrower br
where br.borrower_CardNo not in (
    select distinct bl.book_loans_CardNo
    from tbl_book_loans bl
);
go

-- 27. Books loaned out from "Sharpstown" branch due today, with borrower details.
select * from tbl_book_loans
select * from tbl_borrower
select * from tbl_library_branch

select 
	br.borrower_BorrowerName, 
	br.borrower_CardNo, 
	b.book_Title, 
	bl.book_loans_DueDate
from tbl_borrower br
join tbl_book_loans bl 
on br.borrower_CardNo = bl.book_loans_CardNo
join tbl_book b 
on bl.book_loans_BookID = b.book_BookID
join tbl_library_branch lb 
on bl.book_loans_BranchID = lb.library_branch_BranchID
where lb.library_branch_BranchName = 'Sharpstown'
and bl.book_loans_DueDate = cast(getdate() as date)
order by bl.book_loans_DueDate;
go

-- 28. For each branch, total books loaned out.
select * from tbl_library_branch
select * from tbl_book_loans

select 
	lb.library_branch_BranchName, 
	count(bl.book_loans_BookID) as TotalBooksLoaned
from tbl_library_branch lb
join tbl_book_loans bl 
on lb.library_branch_BranchID = bl.book_loans_BranchID
group by lb.library_branch_BranchName
order by TotalBooksLoaned desc;
GO

--Thank you!