use assignment

/*Q1. to list the candidates have all the required skills such as DS, Tableau, SQL, Python*/

-- Create Table Candidates
create table Candidates
(Id int,
Tech varchar(20)
);

-- Inserting values in Candidates
Insert into candidates (Id,Tech)
values 
(1, "DS"),
(1, "Tableau"),
(1, "SQL"),
(2, "R"),
(2, "Power BI"),
(1, "Python")

-- Answer 

SELECT Id
FROM Candidates
WHERE Tech IN ('DS', 'Tableau', 'SQL', 'Python')
GROUP BY Id

/*Q2. Return Ids of the product info that have zero likes*/

-- Create Table Products_info
create table Products_info
(Pro_id int,
Products varchar(20)
);
-- Inserting values in Products_info
Insert into Products_info (Pro_id,Products)
values 
(1001, "Blog"),
(1002, "Youtube"),
(1003, "Education")

-- Create Table Product_Likes

create table Product_Likes
(User_id int,
Pro_id varchar(20),
Dates date 
);
-- Inserting values in Products_info
INSERT INTO Product_Likes (User_id, Pro_id, Dates)
VALUES 
    (1, 1001, '2023-08-19'),
    (2, 1002, '2023-01-18');

-- Answer 
SELECT p.Pro_id
FROM Products_info p
LEFT JOIN Product_Likes pl ON p.Pro_id = pl.Pro_id
WHERE pl.User_id IS NULL;


