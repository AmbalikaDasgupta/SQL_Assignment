create database Assignment
use Assignment
select * from city limit 100

/*
Q1. Query all columns for all American cities in the CITY table with populations larger than 100000.
The CountryCode for America is USA.
The CITY table is described as follows:
*/

select * 
from city 
where countrycode="USA" and population>100000

/*Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
The CountryCode for America is USA.
The CITY table is described as follows:*/

select name
from city 
where countrycode="USA" and population>120000

/*Q3. Query all columns (attributes) for every row in the CITY table.
The CITY table is described as follows:*/

select * 
from city

/*Q4. Query all columns for a city in CITY with the ID 1661.
The CITY table is described as follows:*/

select * 
from city 
where ID=1661

/*Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is
JPN.
The CITY table is described as follows:*/

select * 
from city
where countrycode="JPN"

/*Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is
JPN.
The CITY table is described as follows:*/

select name
from city
where countrycode="JPN"

/*Q7. Query a list of CITY and STATE from the STATION table.
The STATION table is described as follows:*/

select city,state 
from STATION

/*Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results
in any order, but exclude duplicates from the answer.
The STATION table is described as follows:*/
 
select distinct ID,city
from STATION
where ID%2=0
order by id desc

/*Q9. Find the difference between the total number of CITY entries in the table and the number of
distinct CITY entries in the table.
The STATION table is described as follows:*/

select count(city)-count(distinct city)
from station 

/*Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
largest city, choose the one that comes first when ordered alphabetically.
The STATION table is described as follows:*/

select * from (
select *, LENGTH(city) as city_len, dense_rank() over (order by LENGTH(city)) as city_len_min, dense_rank() over (order by LENGTH(city) desc) as city_len_max
from station
order by LENGTH(city) ) as ss
where city_len_min = 1 or city_len_max = 1

/*Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
cannot contain duplicates.
Input Format
The STATION table is described as follows:*/

select distinct city,left(city,1) as city_v
from station 
where left(city,1) in ("a","e","i","o","u")

# OR

SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiouAEIOU]';

/*Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
contain duplicates.
Input Format
The STATION table is described as follows:*/

select distinct city,right(city,1) as city_v
from station 
where right(city,1) in ("a","e","i","o","u")

#or

SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[aeiouAEIOU]$';

/*Q13. Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
contain duplicates.
Input Format
The STATION table is described as follows:*/

select distinct city
from station 
where city not REGEXP "^[aeiouAEIOU]"

/*Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
contain duplicates.

Input Format
The STATION table is described as follows:*/

select distinct city 
from station
where city not regexp "[aeiouAEIOU]$"

/*Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end
with vowels. Your result cannot contain duplicates.
Input Format
The STATION table is described as follows:*/

select distinct city
from station 
where city not regexp "^[aeiouAEIOU]$"


/*Q16. Query the list of CITY names from STATION that either do not start with vowels or do not end
with vowels. Your result cannot contain duplicates.
Input Format

The STATION table is described as follows:*/
select distinct city
from station 
where city not regexp "^[aeiouAEIOU]$"

/*Q17. Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
between 2019-01-01 and 2019-03-31 inclusive.
Return the result table in any order.
The query result format is in the following example.*/


create table Product (product_id int primary key, product_name varchar (255), unit_price int);
insert into product values
(1, 'S8', 1000),
(2, 'G4', 800),
(3, 'iPhone', 1400)

CREATE TABLE Sales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

insert into Sales values 
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 2, 3, '2019-06-02', 1, 800),
(3, 3, 4, '2019-05-13', 2, 2800);

# Query
p3,p4...   2019-01-01 p1,p2,p3,p5... 2019-03-31 p5,p6....

SELECT p.product_id, p.product_name
FROM Product p
WHERE p.product_id NOT IN (
    SELECT DISTINCT s.product_id
    FROM Sales s
    WHERE s.sale_date >= '2019-04-01' OR s.sale_date < '2019-01-01'
);


/*Q18. Write an SQL query to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.
The query result format is in the following example.*/

CREATE TABLE Views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE)
    
INSERT INTO Views (article_id, author_id, viewer_id, view_date)
VALUES
    (1, 3, 5, '2019-08-01'),
    (1, 3, 6, '2019-08-02'),
    (2, 7, 7, '2019-08-01'),
    (2, 7, 6, '2019-08-02'),
    (4, 7, 1, '2019-07-22'),
    (3, 4, 4, '2019-07-21'),
    (3, 4, 4, '2019-07-21');


select * from Views

-- Query

SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;

/* Q19. If the customer's preferred delivery date is the same as the order date, then the order is called
immediately; otherwise, it is called scheduled.
Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal
places.*/


CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);


INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');

select * from Delivery

-- Query

select 
round(sum(case when order_date = customer_pref_delivery_date then 1 else 0 end)/count(*) * 100,2) as immediately
from delivery

or 
select round((select count(*) from delivery where order_date = 
customer_pref_delivery_date)/count(*)*100,2) as immediate_percentage from
delivery;


/* Q20. Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
tie.*/


CREATE TABLE Ads (
    ad_id INT,
    user_id INT,
    action ENUM('Clicked', 'Viewed', 'Ignored'),
    PRIMARY KEY (ad_id, user_id)
);

INSERT INTO Ads (ad_id, user_id, action)
VALUES
    (1, 1, 'Clicked'),
    (2, 2, 'Clicked'),
    (3, 3, 'Viewed'),
    (5, 5, 'Ignored'),
    (1, 7, 'Ignored'),
    (2, 7, 'Viewed'),
    (3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked');
    
    select * from ads
    -- Query 
    
SELECT ad_id,
IFNULL(ROUND(SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN action IN ('Clicked', 'Viewed') THEN 1 ELSE 0 END), 0) * 100, 2), 0) AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;

 /* Q21. Write an SQL query to find the team size of each of the employees.
Return result table in any order.  */
    
create table Employee (employee_id int, team_id int)

INSERT INTO Employee (employee_id, team_id)
VALUES
    (1, 8),
    (2, 8),
    (3, 8),
    (4, 7),
    (5, 9),
    (6, 9);


with emp2 as (
select team_id, count(team_id) as c_id
from employee
group by team_id)

select e1.employee_id, e2.c_id
from employee as e1 inner join emp2 as e2 on e1.team_id = e2.team_id



/* Q22. Write an SQL query to find the type of weather in each country for November 2019.
The type of weather is:
● Cold if the average weather_state is less than or equal 15,
● Hot if the average weather_state is greater than or equal to 25, and
● Warm otherwise.
Return result table in any order.  */

Create table Countries (country_id int primary key,
country_name varchar (255))


INSERT INTO Countries (country_id, country_name)
VALUES
    (2, 'USA'),
    (3, 'Australia'),
    (7, 'Peru'),
    (5, 'China'),
    (8, 'Morocco'),
    (9, 'Spain');
    
-- Create the Weather table
CREATE TABLE Weather (
    country_id INT,
    weather_state INT,
    day DATE,
    PRIMARY KEY (country_id, day)
);

-- Insert data into the Weather table
INSERT INTO Weather (country_id, weather_state, day)
VALUES
    (2, 15, '2019-11-01'),
    (2, 12, '2019-10-28'),
    (2, 12, '2019-10-27'),
    (3, -2, '2019-11-10'),
    (3, 0, '2019-11-11'),
    (3, 3, '2019-11-12'),
    (5, 16, '2019-11-07'),
    (5, 18, '2019-11-09'),
    (5, 21, '2019-11-23'),
    (7, 25, '2019-11-28'),
    (7, 22, '2019-12-01'),
    (7, 20, '2019-12-02'),
    (8, 25, '2019-11-05'),
    (8, 27, '2019-11-15'),
    (8, 31, '2019-11-25'),
    (9, 7, '2019-10-23'),
    (9, 3, '2019-12-23');
    
    select * from weather
    
  ---Query

with avg_weather  as
(select country_id,avg(weather_state) as av_weather, 
    case when avg(weather_state) <= 15 then "Cold" 
     when avg(weather_state) >= 25 then "Hot" 
     else "Warm" end as weather_type
from weather where day between "2019-11-01" and "2019-11-30"
group by country_id)

select c.country_name, aw.weather_type
from Countries as c left join avg_weather as aw 
on c.country_id = aw.country_id
order by c.country_name asc



/* Q23.Write an SQL query to find the average selling price for each product. average_price should be
rounded to 2 decimal places.
Return the result table in any order.  */

CREATE TABLE Prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price DECIMAL(10, 2)
);

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES
    (1, '2019-02-17', '2019-02-28', 5.00),
    (1, '2019-03-01', '2019-03-22', 20.00),
    (2, '2019-02-01', '2019-02-20', 15.00),
    (2, '2019-02-21', '2019-03-31', 30.00);
    
    
CREATE TABLE UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT
);


INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200);
INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES(2,"2019-03-22",30)



select product_id, round(sum(total_price)/sum(units),2) from (
select p.product_id as product_id,p.start_date,p.end_date,p.price,u.units as units, u.purchase_date,p.price*u.units as total_price
from prices as p left join unitssold as u
on p.product_id= u.product_id and u.purchase_date BETWEEN p.start_date and p.end_date) as ss
group by product_id



-------------------------------------------------------------------------------

--us.purchase_date BETWEEN p.start_date AND p.end_date


SELECT p.product_id, p.start_date, p.end_date, p.price, u.units, u.purchase_date
FROM prices AS p
LEFT JOIN unitssold AS u ON p.product_id = u.product_id
WHERE u.purchase_date BETWEEN p.start_date AND p.end_date;

/* Q24.Write an SQL query to report the first login date for each player.
Return the result table in any order. */



CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
    
    ---Query
    
    select player_id, min(event_date)
    from activity
    group by player_id
    order by player_id
    
    or
   
select * from (
select *, row_number() over (partition by player_id order by event_date) as abc
from activity) as ss
where abc = 1


select * from (
select *, row_number() over (partition by player_id order by event_date) as abc
from activity) as ss
where abc = 1


/* Q25. Write an SQL query to report the device that is first logged in for each player.
Return the result table in any order.*/

select player_id, device_id 
from
(select *, dense_rank() over (partition by player_id order by event_date) as date_rank
from Activity) as ss
where date_rank=1

/* Q26. Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
Return result table in any order.*/

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(255),
    product_category VARCHAR(255)
);

INSERT INTO Products (product_id, product_name, product_category)
VALUES
    (1, 'Leetcode Solutions Book', 'Book'),
    (2, 'Jewels of Stringology Book', 'Book'),
    (3, 'HP Laptop', 'Laptop'),
    (4, 'Lenovo Laptop', 'Laptop'),
    (5, 'Leetcode Kit T-shirt', 'T-shirt');
    
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    order_date DATE,
    unit INT
);


INSERT INTO Orders (order_id, product_id, order_date, unit)
VALUES
    (1, 1, '2020-02-05', 60),
    (2, 1, '2020-02-10', 70),
    (3, 2, '2020-01-18', 30),
    (4, 2, '2020-02-11', 80),
    (5, 3, '2020-02-17', 2),
    (6, 3, '2020-02-24', 3),
    (7, 4, '2020-03-01', 20),
    (8, 4, '2020-03-04', 30),
    (9, 4, '2020-03-04', 60),
    (10, 5, '2020-02-25', 50),
    (11, 5, '2020-02-27', 50),
    (12, 5, '2020-03-01', 50);
    
    -----Query
    
    select * 
    from
    (select p.product_name,sum(o.unit) as Total_unit
    from products as p 
    left join orders as o
    on p.product_id=o.product_id
    where order_date between "2020-02-01" and "2020-02-29"
     group by p.product_name) as ss
     where Total_unit>=100
     
     Or
     select p.product_name, sum(o.unit) as unit
from
Products p
left join
Orders o
on p.product_id = o.product_id
where month(o.order_date) = 2 and year(o.order_date) = 2020
group by p.product_id
having unit >= 100
     
    
/* Q27. Write an SQL query to find the users who have valid emails.A
valid e-mail has a prefix name and a domain where:
● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
'_', period '.', and/or dash '-'. The prefix name must start with a letter.
● The domain is '@leetcode.com'.
Return the result table in any order.*/



CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(255),
    mail VARCHAR(255)
);

INSERT INTO Users (user_id, name, mail)
VALUES
    (1, 'Winston', 'winston@leetcode.com'),
    (2, 'Jonathan', 'jonathanisgreat'),
    (3, 'Annabelle', 'bella-@leetcode.com'),
    (4, 'Sally', 'sally.come@leetcode.com'),
    (5, 'Marwan', 'quarz#2020@leetcode.com'),
    (6, 'David', 'david69@gmail.com'),
    (7, 'Shapiro', '.shapo@leetcode.com');
    
    select * from Users

SELECT user_id, mail
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode.com$';

/* Q28. Write an SQL query to report the customer_id and customer_name of customers who have spent at
least $100 in each month of June and July 2020.
Return the result table in any order.*/


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    country VARCHAR(255)
);


INSERT INTO Customers (customer_id, name, country)
VALUES
    (1, 'Winston', 'USA'),
    (2, 'Jonathan', 'Peru'),
    (3, 'Moustafa', 'Egypt');

CREATE TABLE Product1 (
    product_id INT PRIMARY KEY,
    description VARCHAR(255),
    price DECIMAL(10, 2)
);



CREATE TABLE Orders1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT
);

INSERT INTO Orders1 (order_id, customer_id, product_id, order_date, quantity)
VALUES
    (1, 1, 10, '2020-06-10', 1),
    (2, 1, 20, '2020-07-01', 1),
    (3, 1, 30, '2020-07-08', 2),
    (4, 2, 10, '2020-06-15', 2),
    (5, 2, 40, '2020-07-01', 10),
    (6, 3, 20, '2020-06-24', 2),
    (7, 3, 30, '2020-06-25', 2),
    (9, 3, 30, '2020-05-08', 3);
    
---Query 

SELECT ss.customer_id, ss.name
FROM (
    SELECT
        c.customer_id,
        c.name,
        SUM(CASE WHEN MONTH(o.order_date) = 6 AND YEAR(o.order_date) = 2020 THEN (p.price * o.quantity) ELSE 0 END) AS June_spent,
        SUM(CASE WHEN MONTH(o.order_date) = 7 AND YEAR(o.order_date) = 2020 THEN (p.price * o.quantity) ELSE 0 END) AS July_spent
    FROM orders1 AS o
    LEFT JOIN customers AS c ON c.customer_id = o.customer_id
    LEFT JOIN product1 AS p ON o.product_id = p.product_id
    GROUP BY c.customer_id, c.name
) AS ss
WHERE June_spent >= 100 AND July_spent >= 100;


    
/* Q29. Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
Return the result table in any order.*/

CREATE TABLE TVProgram (
    program_date DATE,
    content_id INT,
    channel VARCHAR(255)
);

INSERT INTO TVProgram (program_date, content_id, channel)
VALUES
    ('2020-06-10 08:00', 1, 'LC-Channel'),
    ('2020-05-11 12:00', 2, 'LC-Channel'),
    ('2020-05-12 12:00', 3, 'LC-Channel'),
    ('2020-05-13 14:00', 4, 'Disney Ch'),
    ('2020-06-18 14:00', 4, 'Disney Ch'),
    ('2020-07-15 16:00', 5, 'Disney Ch');
    

CREATE TABLE Content (
    content_id INT PRIMARY KEY,
    title VARCHAR(255),
    Kids_content CHAR(1),
    content_type VARCHAR(255)
);

INSERT INTO Content (content_id, title, Kids_content, content_type)
VALUES
    (1, 'Leetcode Movie', 'N', 'Movies'),
    (2, 'Alg. for Kids', 'Y', 'Series'),
    (3, 'Database Sols', 'N', 'Series'),
    (4, 'Aladdin', 'Y', 'Movies'),
    (5, 'Cinderella', 'Y', 'Movies');

-----Query

select distinct ss.title from
(select c.title,c.kids_content,c.content_type, 
case 
when c.content_type="Movies"  and c.Kids_content="Y" then "Yes" 
else "No" 
end as kid_friendly
from TVProgram as tv left join content as c
on tv.content_id=c.content_id
where 
 month (tv.program_date)=06 and year (tv.program_date)=2020) as ss 
where  kid_friendly="Yes"


/* Q30. Write an SQL query to find the npv of each query of the Queries table.
Return the result table in any order..*/

CREATE TABLE NPV (
    id INT ,
    year INT ,
    npv INT,
    primary key (id,year)
);


INSERT INTO NPV (id, year, npv)
VALUES
    (1, 2018, 100),
    (7, 2020, 30),
    (13, 2019, 40),
    (1, 2019, 113),
    (2, 2008, 121),
    (3, 2009, 12),
    (11, 2020, 99),
    (7, 2019, 0);
    
    select * from NPV
    
    CREATE TABLE Queries (
    id INT ,
    year INT ,
    primary key (id ,year)
);
    
    INSERT INTO Queries (id, year)
VALUES
    (1, 2019),
    (2, 2008),
    (3, 2009),
    (7, 2018),
    (7, 2019),
    (7, 2020),
    (13, 2019);
    
    
-- Answer-- 
	
select q.*, COALESCE(n.npv,0) as npv
from queries as q left join npv as n
on q.id = n.id and q.year=n.year


/* Q32. Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just
show null.
Return the result table in any order.*/


CREATE TABLE Employees1 (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert data into the Employees table
INSERT INTO Employees1 (id, name)
VALUES
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');


CREATE TABLE EmployeeUNI (
    id INT PRIMARY KEY,
    unique_id INT
);


INSERT INTO EmployeeUNI (id, unique_id)
VALUES
    (3, 1),
    (11, 2),
    (90, 3);
    
    -- Answer --
    
    select eu.unique_id, e.name
    from Employees1 as e left join EmployeeUNI as eu
    on e.id=eu.id
    order by eu.unique_id
    
  /*Q33.  Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users
travelled the same distance, order them by their name in ascending order.*/

CREATE TABLE Users2 (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO Users2 (id, name)
VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');
    

CREATE TABLE Rides (
    id INT PRIMARY KEY,
    user_id INT,
    distance INT
);

INSERT INTO Rides (id, user_id, distance)
VALUES
    (1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);

-- Answer--

select u.name, coalesce(sum(r.distance),0) as Distance_travelled
from users2 as u left join rides as r 
on u.id=r.user_id
group by u.name
order by Distance_travelled desc, name asc

/*Q34. Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
and their amount.
Return result table in any order.*/


CREATE TABLE Products2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    product_category VARCHAR(255)
);

INSERT INTO Products2 (product_id, product_name, product_category)
VALUES
    (1, 'Leetcode Solutions Book', 'Book'),
    (2, 'Jewels of Stringology Book', 'Book'),
    (3, 'HP Laptop', 'Laptop'),
    (4, 'Lenovo Laptop', 'Laptop'),
    (5, 'Leetcode Kit T-shirt', 'Clothing');

CREATE TABLE Orders2 (
    product_id INT,
    order_date DATE,
    unit INT
);

Insert into  orders2 (product_id,order_date,unit)
values 
(1,"2020-02-05",60),
(1,"2020-02-10",70),
(2,"2020-01-18",30),
(2,"2020-02-11",80),
(3,"2020-02-17",2),
(3,"2020-02-24",3),
(4,"2020-03-01",20),
(4,"2020-03-04",30),
(4,"2020-03-04",60),
(5,"2020-02-25",50),
(5,"2020-02-27",50),
(5,"2020-03-01",50);

--Answer--

select p.product_name, sum(o.unit) as total_unit
from Products2 as p left join orders2 as o
on p.product_id= o.product_id
where year(o.order_date)=2020 and month (o.order_date)=2
group by p.product_name
having total_unit >=100


/*Q35. Write an SQL query to:
● Find the name of the user who has rated the greatest number of movies. In case of a tie,
return the lexicographically smaller user name.
● Find the movie name with the highest average rating in February 2020. In case of a tie, return
the lexicographically smaller movie name.
The query result format is in the following example.*/



CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255)
);

INSERT INTO Movies (movie_id, title)
VALUES
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');


CREATE TABLE Users3 (
    user_id INT PRIMARY KEY,
    name VARCHAR(255)
);

INSERT INTO Users3 (user_id, name)
VALUES
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');
    
    
CREATE TABLE MovieRating (
    movie_id INT,
    user_id INT,
    rating INT,
    created_at DATE
);

INSERT INTO MovieRating (movie_id, user_id, rating, created_at)
VALUES
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22');


-- Answer--
select result from
(select u.name as result,dense_rank() over (order by m.rating desc) as rank_rating
from Users3 as u left join MovieRating as M
on u.user_id = m.user_id) as ss
where rank_rating =1
union 
select title
from
(select mo.title as title, avg(m.rating) as avg_rating,  
    dense_rank () over (order by avg(m.rating) desc)  as overall_rank
from movies as mo left join MovieRating as M 
on mo.movie_id = M.movie_id
where year(created_at)=2020 and month(created_at)=2
group by mo.title)  as ss
where overall_rank=1


/* Q 36. Write an SQL query to report the distance travelled by each user.
Return the result table ordered by travelled_distance in descending order, if two or more users
travelled the same distance, order them by their name in ascending order.
The query result format is in the following example.*/


-- Answer--

select u.name, coalesce(sum(r.distance),0) as Distance_travelled
from users2 as u left join rides as r 
on u.id=r.user_id
group by u.name
order by Distance_travelled desc, name asc


/* Q 37. Write an SQL query to find the average selling price for each product. average_price should be
rounded to 2 decimal places.*/

-- Answer --

 select eu.unique_id, e.name
    from Employees1 as e left join EmployeeUNI as eu
    on e.id=eu.id
    order by eu.unique_id
    
    
    /* Q 38. Write an SQL query to find the id and the name of all students who are enrolled in departments that no
longer exist.
Return the result table in any order.*/


-- Create the Departments table
CREATE TABLE Departments (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert data into the Departments table
INSERT INTO Departments (id, name)
VALUES
    (1, 'Electrical Engineering'),
    (7, 'Computer Engineering'),
    (13, 'Business Administration');
    
    -- Create the Students table
CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department_id INT
);

-- Insert data into the Students table
INSERT INTO Students (id, name, department_id)
VALUES
    (23, 'Alice', 1),
    (1, 'Bob', 7),
    (5, 'Jennifer', 13),
    (2, 'John', 14),
    (4, 'Jasmine', 77),
    (3, 'Steve', 74),
    (6, 'Luis', 1),
    (8, 'Jonathan', 7),
    (7, 'Daiana', 33),
    (11, 'Madelynn', 1);

-- Answer --
select id, name from Students 
where department_id not in (select id from Departments);

 /* Q 39. Write an SQL query to report the number of calls and the total call duration between each pair of
distinct persons (person1, person2) where person1 < person2.
Return the result table in any order.*/


-- Create the Calls table
CREATE TABLE Calls (
    from_id INT,
    to_id INT,
    duration INT
);

-- Insert data into the Calls table
INSERT INTO Calls (from_id, to_id, duration)
VALUES
    (1, 2, 59),
    (2, 1, 11),
    (1, 3, 20),
    (3, 4, 100),
    (3, 4, 200),
    (3, 4, 200),
    (4, 3, 499);

-- Answer --






/* Q 40. Write an SQL query to find the average selling price for each product. average_price should be rounded
to 2 decimal places.
Return the result table in any order*/

-- Answer --

select product_id, round(sum(total_price)/sum(units),2) from (
select p.product_id as product_id,p.start_date,p.end_date,p.price,u.units as units, u.purchase_date,p.price*u.units as total_price
from prices as p left join unitssold as u
on p.product_id= u.product_id and u.purchase_date BETWEEN p.start_date and p.end_date) as ss
group by product_id

/* Q 41 Write an SQL query to report the number of cubic feet of volume the inventory occupies in each
warehouse.
Return the result table in any order.*/

-- Create Warehouse table
CREATE TABLE Warehouse (
    name VARCHAR(255),
    product_id INT,
    units INT)
    
    -- Insert values into Warehouse table
INSERT INTO Warehouse (name, product_id, units)
VALUES
    ('LCHouse1', 1, 1),
    ('LCHouse1', 2, 10),
    ('LCHouse1', 3, 5),
    ('LCHouse2', 1, 2),
    ('LCHouse2', 2, 2),
    ('LCHouse3', 4, 1);
    
  -- Create Products table

-- Insert values into Products table
INSERT INTO Products3 (product_id, product_name, Width, Length, Height)
VALUES
    (1, 'LC-TV', 5, 50, 40),
    (2, 'LC-KeyChain', 5, 5, 5),
    (3, 'LC-Phone', 2, 10, 10),
    (4, 'LC-T-Shirt', 4, 10, 20);
  
 -- Answe
    select w.name as warehouse, 
    SUM(p.Width * p.Length * p.height * w.units) as Volume
    from Warehouse as w 
    left join 
    products3 as p
    on w.product_id=p.product_id
	group by w.name
    
    /* Q 42. Write an SQL query to report the difference between the number of apples and oranges sold each day.
Return the result table ordered by sale_date.
The query result format is in the following example.*/

-- Create Sales table
CREATE TABLE Sales1 (
    sale_date DATE,
    fruit VARCHAR(255),
    sold_num INT
);

-- Insert values into Sales table
INSERT INTO Sales1 (sale_date, fruit, sold_num)
VALUES
    ('2020-05-01', 'apples', 10),
    ('2020-05-01', 'oranges', 8),
    ('2020-05-02', 'apples', 15),
    ('2020-05-02', 'oranges', 15),
    ('2020-05-03', 'apples', 20),
    ('2020-05-03', 'oranges', 0),
    ('2020-05-04', 'apples', 15),
    ('2020-05-04', 'oranges', 16);

-- Answer
with CTE as (select sale_date,
max(case when fruit="apples" then sold_num else 0 end) as Apples,
max(case when fruit="oranges" then sold_num else 0 end) as orange
from sales1
group by sale_date)

select sale_date, (Apples-orange) as Diff
from CTE

/* Q 43. Write an SQL query to report the fraction of players that logged in again on the day after the day they
first logged in, rounded to 2 decimal places. In other words, you need to count the number of players
that logged in for at least two consecutive days starting from their first login date, then divide that
number by the total number of players.
The query result format is in the following example.*/

CREATE TABLE Activity1 (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

-- Insert values into Activity table
INSERT INTO Activity1 (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-03-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
    

    
    select round(t.player_id/(select count(distinct player_id) from activity1),2) as
fraction
from
(
select distinct player_id,
datediff(event_date, lead(event_date, 1) over(partition by player_id order by
event_date)) as diff
from activity1 ) t
where diff = -1;

/* Q 44. Write an SQL query to report the managers with at least five direct reports.
Return the result table in any order.
The query result format is in the following example.*/

-- Create Employee table
CREATE TABLE Employee1 (
    id INT,
    name VARCHAR(255),
    department VARCHAR(255),
    managerId INT
);

-- Insert values into Employee table
INSERT INTO Employee1 (id, name, department, managerId)
VALUES
    (101, 'John', 'A', NULL),
    (102, 'Dan', 'A', 101),
    (103, 'James', 'A', 101),
    (104, 'Amy', 'A', 101),
    (105, 'Anne', 'A', 101),
    (106, 'Ron', 'B', 101);
    
    Select * from Employee1
    
    SELECT
    managerId AS employee_id,
    COUNT(id) AS report_count
FROM
    Employee1
WHERE
    managerId IS NOT NULL
GROUP BY
    managerId
HAVING
    COUNT(id) >= 5;

/* Q 45. Write an SQL query to report the respective department name and number of students majoring in
each department for all departments in the Department table (even ones with no current students).
Return the result table ordered by student_number in descending order. In case of a tie, order them by
dept_name alphabetically.
The query result format is in the following example.*/

-- Create Student table
CREATE TABLE Student (
    student_id INT,
    student_name VARCHAR(255),
    gender CHAR(1),
    dept_id INT
);

-- Insert values into Student table
INSERT INTO Student (student_id, student_name, gender, dept_id)
VALUES
    (1, 'Jack', 'M', 1),
    (2, 'Jane', 'F', 1),
    (3, 'Mark', 'M', 2);
    
    
    -- Create Department table
CREATE TABLE Department (
    dept_id INT,
    dept_name VARCHAR(255)
);

-- Insert values into Department table
INSERT INTO Department (dept_id, dept_name)
VALUES
    (1, 'Engineering'),
    (2, 'Science'),
    (3, 'Law');
    
  -- Answer 
    select d.dept_name, count(s.student_name) as total_student
    from Department as d left join Student as s
    on d.dept_id =s.dept_id
    group by d.dept_name

/* Q 46. Write an SQL query to report the customer ids from the Customer table that bought all the products in
the Product table.
Return the result table in any order.
The query result format is in the following example.*/

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT,
    product_key INT
);

-- Insert values into Customer table
INSERT INTO Customer (customer_id, product_key)
VALUES
    (1, 5),
    (2, 6),
    (3, 5),
    (3, 6),
    (1, 6);

-- Create Product table
CREATE TABLE Product3 (
    product_key INT
);

-- Insert values into Product table
INSERT INTO Product3 (product_key)
VALUES
    (5),
    (6);
    
   
-- Answer    
select customer_id
from
customer
group by customer_id
having count(distinct product_key)=(select count(*) from product3);

/* Q 47. Write an SQL query that reports the most experienced employees in each project. In case of a tie,
report all employees with the maximum number of experience years.
Return the result table in any order.
The query result format is in the following example.*/

-- Create Project table
CREATE TABLE Project (
    project_id INT,
    employee_id INT
);

-- Insert values into Project table
INSERT INTO Project (project_id, employee_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 4);
drop table employee2
-- Create Employee table
CREATE TABLE Employee2 (
    employee_id INT,
    employee_name VARCHAR(255),
    experience_years INT
);

-- Insert values into Employee table
INSERT INTO Employee2 (employee_id, employee_name, experience_years)
VALUES
    (1, 'Khaled', 3),
    (2, 'Ali', 2),
    (3, 'John', 3),
    (4, 'Doe', 2);
-- Answer 
select ss.project_id, ss.employee_id
from
(select p.project_id, e.employee_id,e.experience_years, dense_rank () over (partition by project_id order by experience_years desc) as r
from 
Employee2 as e 
left join  Project as p 
on e.employee_id= p.employee_id) as ss
where r=1

/* Q 48. Write an SQL query that reports the books that have sold less than 10 copies in the last year,
excluding books that have been available for less than one month from today. Assume today is
2019-06-23.
Return the result table in any order.
The query result format is in the following example.*/

-- Create Books table
CREATE TABLE Books (
    book_id INT,
    name VARCHAR(255),
    available_from DATE
);

-- Insert values into Books table
-- Create Orders table
CREATE TABLE Orders3 (
    order_id INT,
    book_id INT,
    quantity INT,
    dispatch_date DATE
);

-- Insert values into Orders table
INSERT INTO Orders3 (order_id, book_id, quantity, dispatch_date)
VALUES
    (1, 1, 2, '2018-07-26'),
    (2, 1, 1, '2018-11-05'),
    (3, 3, 8, '2019-06-11'),
    (4, 4, 6, '2019-06-05'),
    (5, 4, 5, '2019-06-20'),
    (6, 5, 9, '2009-02-02'),
    (7, 5, 8, '2010-04-13');
    
    
    select t1.book_id, t1.name
from
(
(select book_id, name from Books where
available_from < '2019-05-23') t1
left join
(select book_id, sum(quantity) as quantity
from Orders3
where dispatch_date > '2018-06-23' and dispatch_date<= '2019-06-23'
group by book_id
having quantity < 10) t2
on t1.book_id = t2.book_id
)


/* Q 49. Write a SQL query to find the highest grade with its corresponding course for each student. In case of
a tie, you should find the course with the smallest course_id.
Return the result table ordered by student_id in ascending order.
The query result format is in the following example.*/

-- Create Enrollments table
CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    grade INT
);

-- Insert values into Enrollments table
INSERT INTO Enrollments (student_id, course_id, grade)
VALUES
    (2, 2, 95),
    (2, 3, 95),
    (1, 1, 90),
    (1, 2, 99),
    (3, 1, 80),
    (3, 2, 75),
    (3, 3, 82);

-- Answer
select student_id,course_id,grade
from
(select *, dense_rank () over (partition by student_id order by grade desc, course_id) as r
from Enrollments) as s
where r=1

/* Q 50. The winner in each group is the player who scored the maximum total points within the group. In the
case of a tie, the lowest player_id wins.
Write an SQL query to find the winner in each group.
Return the result table in any order.
The query result format is in the following example.*/

-- Create Players table
CREATE TABLE Players (
    player_id INT,
    group_id INT
);

-- Insert values into Players table
INSERT INTO Players (player_id, group_id)
VALUES
    (15, 1),
    (25, 1),
    (30, 1),
    (45, 1),
    (10, 2),
    (35, 2),
    (50, 2),
    (20, 3),
    (40, 3);
    
    -- Create Matches table
CREATE TABLE Matches (
    match_id INT,
    first_player INT,
    second_player INT,
    first_score INT,
    second_score INT
);

INSERT INTO Matches (match_id,first_player,second_player,first_score,second_score)
VALUES
    (1, 15,45,3,0),
    (2, 30,25,1,2),
    (3, 30,15,2,0),
    (4, 40,20,5,2),
    (5, 35,50,1,1);
    
   -- Answer
   select t2.group_id, t2.player_id from
(
select t1.group_id, t1.player_id, 
dense_rank() over(partition by group_id order by score desc, player_id) as r
from
(
select p.*, case when p.player_id = m.first_player then m.first_score
when p.player_id = m.second_player then m.second_score
end as score
from
Players p, Matches m
where player_id in (first_player, second_player)
) t1
) t2
where r = 1;








    

