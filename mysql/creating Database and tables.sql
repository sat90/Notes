drop database if exists Store;
create Database Store;

USE Store;

-- entities

create table customers(
cFirstName varchar(20) NOT NULL,
cLastName varchar(20)  NOT NULL,
cEmail varchar(50) NOT NULL,
cphonenr int,
cAdr varchar(50) DEFAULT 'Stavanger',
cID int NOT NULL AUTO_INCREMENT,
PRIMARY KEY(cID)
);

insert into customers
VALUES('john', 'johnsen','johnsen93@hotmail.com','50515253','norgesgate 15, 4014 stavanger', NULL);

insert into customers
VALUES('Stephen', 'Stephensen','Stephensen80@hotmail.com','90929394','norgesgate 20, 4014 oslo', NULL);

insert into customers
(cFirstName, cLastName, cEmail)
VALUES
("stian", "taksdal","stiantakstdal@hotmail.com"),
("Odd","norstoga","Oddnorstoga@hotmail.com"),
("vegard","kvinesdal","vegardcyanid@hotmail.com");

create table employees(
eFirstName varchar(20),
eLastName varchar(20),
eID int NOT NULL AUTO_INCREMENT,
eEmail varchar(50),
eMonthsEmployed int,
eAdr varchar(50),
ePhonenr int,
PRIMARY KEY(eID)
);

insert into employees
VALUES('Steffen','Trovik',null,'steffen.90@hotmail.com', '10','norgesgate 6, 4014 stvg','90939495');

insert into employees
VALUES('Kim','Kimsen',null,'kim.800@hotmail.com', '20','norgesgate 8, 4014 stvg','90939495');

create table orders(
oID int NOT NULL AUTO_INCREMENT,
oStartDate int,
oEndDate int,
cID int not null,
eID int,
PRIMARY KEY(oID),
FOREIGN KEY (cID) REFERENCES customers(cID),
FOREIGN KEY (eID) REFERENCES employees(eID)
);

insert into orders
VALUES(NULL, '29012018','29012019',1,1);

insert into orders
VALUES(NULL, '20022018','29012019',2,2);



create table lager(
lID int NOT NULL AUTO_INCREMENT,
lAdr varchar(50),
boss int,
FOREIGN key(boss) REFERENCES employees(eID),
PRIMARY KEY(lID)
);

insert into lager
VALUES(NULL,'norgesgate 50, 4014 stvg',1);

insert into lager
VALUES(NULL,'norgesgate 60, 4014 stvg',1);

create table products(
pID int NOT NULL AUTO_INCREMENT,
pPrice int,
pNavn varchar(50),
PRIMARY KEY(pID)
);

insert into products
VALUES(NULL, '200', 'ball');

insert into products
VALUES(NULL, '400', 'bat');

insert into products
(pPrice, pNavn)
VALUES
("500","glove"),
("800","shirt");

-- relations

create table ocp(
oID int,
pID int,
FOREIGN key(oID) REFERENCES orders(oID),
FOREIGN KEY(pID) REFERENCES products(pID)
);

insert into ocp
(oID,pID)
values
(1,1),
(1,2),
(1,3),
(2,1),
(2,1);


create table lcp(
lID int,
pID int,
FOREIGN key(lID) REFERENCES lager(lID),
FOREIGN KEY(pID) REFERENCES products(pID)
);





-- stuff

-- DROP DATABASE Firma;
-- DROP TABLE customers;


DESC customers;

-- shows customer info
SELECT customers.cID,customers.cFirstName, customers.cLastName,customers.cEmail
FROM customers order by cFirstName;

-- shows customer paired with their orders
SELECT orders.oID,orders.cID,customers.cFirstName
FROM orders
INNER JOIN customers ON orders.cID=customers.cID;

-- shows the products in order with id 1
SELECT ocp.oID,ocp.pID AS OrderDetails
FROM ocp where oID=1;
-- INNER JOIN products ON ocp.pID=orders.pID;

-- shows customers sorted alphabetically by firstname
SELECT customers.cID,customers.cFirstName, customers.cLastName,customers.cEmail
FROM customers order by cFirstName;


SELECT ocp.oID,ocp.pID
FROM ocp group by pID;

-- sum
 SELECT SUM(pprice) AS completeKitprice FROM products;



-- counts avaliable products
SELECT COUNT(pID) AS NumberOfProducts FROM Products;

-- counts registered customers
SELECT COUNT(cID) AS NumberOfcustomers FROM customers;


-- min
SELECT MIN(pPrice) AS SmallestPrice FROM products;

-- max
SELECT MAX(pPrice) AS BiggesrPrice FROM products;

-- avg
SELECT AVG(pPrice) AS AvgPrice FROM products;

 -- shows different prices
SELECT DISTINCT pPrice FROM products;


-- wildcard to create a view of all stavangerkudner
CREATE VIEW Stavangerkunder AS
SELECT cFirstName, cLastName, cAdr
FROM Customers
-- where Locate(cAdr,'stavanger')!=0;
WHERE cAdr LIKE '%stavanger%';

-- shows the view
SELECT * FROM stavangerkunder;

-- ??
SELECT cID, eID
FROM customers, employees
WHERE cID <> eID;


-- left join, shows all customers, with values order values on the ones who have completed an order
SELECT *
FROM customers
left JOIN orders ON customers.cID=orders.oID
ORDER BY customers.cFirstName;

-- using in, products which have been ordered
SELECT * FROM products
WHERE pID IN (SELECT pID FROM ocp);



